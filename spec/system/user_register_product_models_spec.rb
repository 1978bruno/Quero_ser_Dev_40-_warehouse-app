require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'com sucesso' do
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', regist_number:'4344721600',
                              full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', 
                              email: 'contato@samsung.com')

    visit(root_path)
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome' , with: 'TV 40"'
    fill_in 'Peso', with: 10_000
    fill_in 'Altura', with: 60
    fill_in 'Largura', with: 90
    fill_in 'Profundidade', with: 10
    fill_in 'Código único', with: 'TV40-SAMS-XPTO'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'

    expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
    expect(page).to have_content 'TV 40'
    expect(page).to have_content 'Código único: TV40-SAMS-XPTO'
    expect(page).to have_content 'Dimensão: 60 x 90 x 10'
    expect(page).to have_content 'Peso: 10000g'
    expect(page).to have_content 'Fornecedor: Samsung'
  end
end