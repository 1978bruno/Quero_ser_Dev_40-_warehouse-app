require 'rails_helper'

describe 'Usuário atualiza status do pedido' do
  it 'e pedido foi entegue' do
    joao = User.create!(name: 'João', email:'joao@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'SDU', code: 'SDU1', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, height: 100,
                                   width:70, depht: 75, sku: 'CAD-GAMER-1234')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.day.from_now, status: :pending)
    OrderItem.create!(order: order, product_model: product, quantity: 5)

    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como entregue'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Situação do Pedido: Entregue')
    expect(page).not_to have_button('Marcar como cancelado')
    expect(page).not_to have_button('Marcar como entregue')
    expect(StockProduct.count).to eq 5
    expect(StockProduct.where(product_model: product, warehouse: warehouse).count).to eq 5
  end
  it 'e pedido foi cancelado' do
    joao = User.create!(name: 'João', email:'joao@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'SDU', code: 'SDU1', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, height: 100,
                                width:70, depht: 75, sku: 'CAD-GAMER-1234')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.day.from_now, status: :pending)
    OrderItem.create!(order: order, product_model: product, quantity: 5)

    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como cancelado'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content('Situação do Pedido: Cancelado')
    expect(StockProduct.count).to eq 0
  end
end