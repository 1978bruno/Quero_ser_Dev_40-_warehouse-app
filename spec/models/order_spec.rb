require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
                        estimated_delivery_date: '2023-01-23')

      result = order.valid?

      expect(result).to be true
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
                        estimated_delivery_date: '2023-01-23')

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
                                 estimated_delivery_date: '2023-01-23')
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: '2023-01-23')

      second_order.save

      expect(second_order.code).not_to eq first_order.code
    end
  end
end
