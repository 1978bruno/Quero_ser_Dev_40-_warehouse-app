require 'rails_helper'

describe 'Usuário vê fornecedor' do
  it 'na página inicial de fornecedor' do
    
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end

    expect(current_path).to eq suppliers_path
  end
  it 'com sucesso' do
    Supplier.create!(corp_name: 'ACM LTDA', brand_name: 'ACME', regist_number:'4344721600',
                    full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    Supplier.create!(corp_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', regist_number:'4344721601',
                    full_addr: 'Torre da Industria, 1', city: 'Teresina', state: 'PI', email: 'venda@acme.com')

    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'ACM LTDA'
    expect(page).to have_content '4344721600'
    expect(page).to have_content 'Spark Industries Brasil LTDA'
    expect(page).to have_content '4344721601'
  end
  it 'e não existe fornecedor cadastrado' do
    
    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content ('Não existem fornecedores cadastrados')
  end
end