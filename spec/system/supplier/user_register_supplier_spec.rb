require 'rails_helper'

describe 'Usuário cadastra um Fornecedor' do
  it 'a partir da tela inicial' do


    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'

    expect(page).to have_field('Razão Social')
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Email')
  end
  it 'Com sucesso' do

    
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    
    fill_in 'Razão Social', with: 'ACM LTDA'
    fill_in 'Nome Fantasia', with: 'ACME'
    fill_in 'Email', with: 'contato@acme.com'
    fill_in 'Endereço',   with: 'Av. das Palmas, 100'
    fill_in 'CNPJ', with: '4344721600'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    click_on 'Criar Fornecedor'


    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor cadastrado com sucesso'
    expect(page).to have_content 'ACM LTDA'
    expect(page).to have_content '4344721600'
  end

  it 'Sem sucesso' do


    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social',       with: ''
    fill_in 'Nome Fantasia',     with: ''
    fill_in 'Email',  with: ''
    click_on 'Criar Fornecedor'


     expect(page).to have_content 'Fornecedor não cadastrado'
     expect(page).to have_content 'Razão Social não pode ficar em branco'
     expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
     expect(page).to have_content 'Email não pode ficar em branco'

  end
end