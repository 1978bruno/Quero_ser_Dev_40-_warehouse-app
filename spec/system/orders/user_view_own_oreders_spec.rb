require 'rails_helper'

describe 'Usuario vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    

    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_user_session_path
  end
  it 'e não vê outros pedidos' do
    bruno = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    joao = User.create!(name: 'João', email:'joao@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'SDU', code: 'SDU1', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                  regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                  city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    order1 = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now, status: 'pending')
    order2 = Order.create!(user: bruno, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now, status: 'delivered')
    order3 = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.week.from_now, status: 'canceled')
    
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content order1.code
    expect(page).to have_content 'Pendente'
    expect(page).to have_content order3.code
    expect(page).to have_content 'Cancelado'
    expect(page).not_to have_content order2.code
    expect(page).not_to have_content 'Entregue'
  end
  it 'e visita um pedido' do
    bruno = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'SDU', code: 'SDU1', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    order = Order.create!(user: bruno, warehouse: warehouse, supplier: supplier, 
                           estimated_delivery_date: 1.day.from_now)
                    
    login_as(bruno)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content order.code
    expect(page).to have_content 'Galpão Destino: SDU1 - SDU'
    expect(page).to have_content 'Fornecedor: Samsung Eletronics LTDA'
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista: #{formatted_date}" 

  end
  it 'e não visita pedidos de outros usuários' do
    bruno = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    joao = User.create!(name: 'João', email:'joao@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'SDU', code: 'SDU1', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    order = Order.create!(user: bruno, warehouse: warehouse, supplier: supplier, 
                           estimated_delivery_date: 1.day.from_now)
                    
    login_as(joao)
    visit order_path(order.id)

    expect(current_path).not_to eq order_path(order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido'
  end
end