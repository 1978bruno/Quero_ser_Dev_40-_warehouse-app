require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
      supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                  regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                  city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                        estimated_delivery_date: 1.day.from_now)

      expect(order.valid?).to be true
    end
    it 'data estimada de entrega deve ser obrigatória' do
      order = Order.new(estimated_delivery_date: '')

      order.valid?

      expect(order.errors.include?(:estimated_delivery_date)).to be true
    end
    it 'data estimada de entrega não deve ser anterior' do
      order = Order.new(estimated_delivery_date: 1.day.ago)

      order.valid?

      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(" deve ser futuro")
    end
    it 'data estimada de entrega deve ser diferente de hoje' do
      order = Order.new(estimated_delivery_date: Date.today)

      order.valid?

      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(" deve ser futuro")
    end
    it 'data estimada de entrega deve ser igual ou maior que amanhã' do
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      order.valid?

      expect(order.errors.include?(:estimated_delivery_date)).to be false
    end
  end
  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
      supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                  regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                  city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                        estimated_delivery_date: 1.day.from_now)

      order.save

      expect(order.code).not_to be_empty
      expect(order.code.length).to eq 8
    end
    it 'e o pedido é único' do
      user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
      supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                  regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                  city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                 estimated_delivery_date: 1.day.from_now)
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now)

      second_order.save

      expect(second_order.code).not_to eq first_order.code
    end
    it 'e não se altera' do
      user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
      supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                  regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                  city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                        estimated_delivery_date: 1.week.from_now)
      original_code = order.code

      order.update!(estimated_delivery_date: 1.month.from_now)

      expect(order.code).to eq original_code
    end
  end
end
