require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'e deve estar autenticado' do
    
    visit root_path

    within('header nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end
  end
  it 'a partir do menu' do
    user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')

    login_as(user)
    visit root_path

    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end
  it 'e encontra um pedido' do
    user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                              regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                              city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                  estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    expect(page).to have_content "Resultado da Busca por: #{order.code}"
    expect(page).to have_content '1 Pedido Encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content 'Galpão Destino: SDU - Rio'
    expect(page).to have_content 'Fornecedor: Samsung Eletronics LTDA'
  end
  it 'e encontra multiplos pedidos' do
    user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    warehouse1 = Warehouse.create!(name: 'SDU', code: 'SDU1', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    warehouse2 = Warehouse.create!(name: 'SDU', code: 'SDU2', city: 'Rio de Janeiro', area: 80_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    warehouse3 = Warehouse.create!(name: 'BHE', code: 'CGA', city: 'Belo Horizonte', area: 60_000,
                                  address: 'Linha Verda, 30000', cep: '31000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU1234') 
    order1 = Order.create!(user: user, warehouse: warehouse1, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU56789')
    order2 = Order.create!(user: user, warehouse: warehouse2, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CGA123456')
    order3 = Order.create!(user: user, warehouse: warehouse3, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now)
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: "SDU"
    click_on 'Buscar'

    expect(page).to have_content '2 Pedidos Encontrados'
    expect(page).to have_content 'SDU1234'
    expect(page).to have_content 'SDU56789'
    expect(page).not_to have_content 'CGA123456'
    expect(page).not_to have_content 'Galpão Destino: SDU - Rio'

  end
end