require 'rails_helper'

describe 'Usuário vê detalhes de um Fornecedor' do
  it 'e vê informações adicionais' do
    #Arrange
    s = Supplier.create!(corp_name: 'ACM LTDA', brand_name: 'ACME', regist_number:'4344721600',
                    full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', 
                    email: 'contato@acme.com')
    s.save

    #act
    visit(root_path)
    click_on('Fornecedores')
    click_on('ACM LTDA')

    #assert
    expect(page).to have_content('Nome Fantasia: ACME')
    expect(page).to have_content('Razão Social: ACM LTDA')
    expect(page).to have_content('Cidade: Bauru')
    expect(page).to have_content('Endereço: Av. das Palmas, 100')
    expect(page).to have_content('CNPJ: 4344721600')
    expect(page).to have_content('Email: contato@acme.com')
  end
end