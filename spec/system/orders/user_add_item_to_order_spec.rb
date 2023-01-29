require 'rails_helper'

describe 'Usuário adciona itens ao pedido' do
  it 'com sucesso' do
    joao = User.create!(name: 'João', email:'joao@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'SDU', code: 'SDU1', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height:20, depht: 30, 
                                    supplier: supplier, sku: 'PRODUTO-A')
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height:20, depht: 30, 
                                     supplier: supplier, sku: 'PRODUTO-B')

    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: '8'
    click_on 'Gravar'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'
  end
  it 'e não vê produtos de outro fornecedor' do
    joao = User.create!(name: 'João', email:'joao@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'SDU', code: 'SDU1', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier_a = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    supplier_b = Supplier.create!(corp_name: 'ACME LTDA', brand_name: 'ACME', 
                                regist_number:'4344721610', full_addr: 'Av. das Palmas, 1000', 
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier_a, 
                          estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height:20, depht: 30, 
                                    supplier: supplier_a, sku: 'PRODUTO-A')
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height:20, depht: 30, 
                                     supplier: supplier_b, sku: 'PRODUTO-B')

    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    
    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end
end