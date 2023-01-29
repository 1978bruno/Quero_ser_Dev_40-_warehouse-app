require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    

    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    other_supplier = Supplier.create!(corp_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', 
                                      regist_number:'4344721601', full_addr: 'Torre da Industria, 1', 
                                      city: 'Teresina', state: 'PI', email: 'venda@acme.com')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                              regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                              city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    other_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', 
                                        area: 80_000, address: 'Avenida tiradentes, 9999', cep: '31000-000', 
                                        description: 'Galpão destinado para cargas mineiras')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
    date_valid = 1.day.from_now

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'SDU - Rio', from: 'Galpão Destino'
    select supplier.corp_name, from: 'Fornecedor'
    fill_in 'Data Prevista', with: date_valid.strftime('%d/%m/%Y')
    click_on 'Gravar'

    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido '
    expect(page).to have_content 'Galpão Destino: SDU - Rio'
    expect(page).to have_content 'Fornecedor: Samsung Eletronics LTDA'
    expect(page).to have_content 'Usuário Responsável: Bruno - bruno@email.com'
    expect(page).to have_content 'Situação do Pedido: Pendente'
    expect(page).to have_content  date_valid.strftime('%d/%m/%Y')
    expect(page).not_to have_content 'Galpão destino: Belo Horizonte'
    expect(page).not_to have_content 'Fornecedor: Spark Industries Brasil LTDA'
  end
  it 'e não informa a data de entrega' do
    user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                              regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                              city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'SDU - Rio', from: 'Galpão Destino'
    select supplier.corp_name, from: 'Fornecedor'
    fill_in 'Data Prevista', with: ''
    click_on 'Gravar'

    expect(page).to have_content 'Não foi possível registrar o pedido'
    expect(page).to have_content 'Data prevista de Entrega não pode ficar em branco'
  end
end