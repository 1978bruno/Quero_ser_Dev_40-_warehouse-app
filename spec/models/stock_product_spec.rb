require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'Gera um número de série' do
    it 'ao criar um Stock Product' do
      user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
      supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                  regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                  city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, status: :delivered,
                        estimated_delivery_date: 1.week.from_now)
      product = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, height: 70, width: 75,
                                    supplier: supplier, depht: 80, sku: 'CGMER-XPTO-888')
      
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      expect(stock_product.serial_number.length).to eq 20
    end
    it 'e não é modificado' do
      user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
      supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                  regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                  city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      other_warehouse = Warehouse.create!(name: 'Guarulhos', code: 'GUA', city: 'São Paulo', area: 40_000,
                                    address: 'Avenida dois, 2000', cep: '11000-000', 
                                    description: 'Galpão destinado para cargas nacionais')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, status: :delivered,
                        estimated_delivery_date: 1.week.from_now)
      product = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, height: 70, width: 75,
                                    supplier: supplier, depht: 80, sku: 'CGMER-XPTO-888')
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      original_serial_number = stock_product.serial_number

      stock_product.update!(warehouse:other_warehouse)

      expect(stock_product.serial_number).to eq original_serial_number
    end
  end
end
