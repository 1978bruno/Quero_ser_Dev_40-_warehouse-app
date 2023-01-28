require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    bruno = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'SDU', code: 'SDU1', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    order = Order.create!(user: bruno, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.day.from_now)
    
    visit edit_order_path(order.id)

    expect(current_path).to eq new_user_session_path
  end
  it 'com successo' do
    bruno = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'SDU', code: 'SDU1', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    Supplier.create!(corp_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', regist_number:'4344721601',
                                full_addr: 'Torre da Industria, 1', city: 'Teresina', state: 'PI', email: 'venda@acme.com')
              
    order = Order.create!(user: bruno, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.day.from_now)
    
    login_as(bruno)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista', with: '12/12/2023'
    select 'Spark Industries Brasil LTDA', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido atualizado com sucesso'
    expect(page).to have_content 'Fornecedor: Spark Industries Brasil LTDA'
    expect(page).to have_content 'Data Prevista: 12/12/2023'
  end
  it 'se o responsável' do
    bruno = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    joao = User.create!(name: 'João', email:'joao@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'SDU', code: 'SDU1', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.day.from_now)
    
    login_as(bruno)
    visit edit_order_path(order.id)

    expect(current_path).to eq root_path
  end
end