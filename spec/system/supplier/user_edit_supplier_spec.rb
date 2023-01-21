require  'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da pagina de detalhes de um fornecedor' do
    s = Supplier.create!(corp_name: 'ACM LTDA', brand_name: 'ACME', regist_number:'4344721600',
                    full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', 
                    email: 'contato@acme.com')
    s.save

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACM LTDA'

    expect(page).to have_content 'Editar'
    expect(page).to have_content 'Razão Social: ACM LTDA' 
    expect(page).to have_content 'Nome Fantasia: ACME' 
    expect(page).to have_content 'CNPJ: 4344721600' 
    expect(page).to have_content 'Endereço: Av. das Palmas, 100' 
    expect(page).to have_content 'Cidade: Bauru - SP'
    expect(page).to have_content 'Email: contato@acme.com'
    
  end
  it 'com sucesso' do
    s = Supplier.create!(corp_name: 'ACM LTDA', brand_name: 'ACME', regist_number:'4344721600',
                    full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', 
                    email: 'contato@acme.com')
    s.save

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACM LTDA'
    click_on 'Editar'
    fill_in 'Razão Social', with: 'ACM'
    fill_in 'Nome Fantasia', with: 'ACME CO. and IND.'
    fill_in 'CNPJ', with: '160003000'
    fill_in 'Endereço', with: 'Av. Funcionários, 50'
    click_on 'Atualizar Fornecedor'

    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'Razão Social: ACM'
    expect(page).to have_content 'Endereço: Av. Funcionários, 50'
    expect(page).to have_content 'Nome Fantasia: ACME CO. and IND.'
    expect(page).to have_content 'CNPJ: 160003000'
  end
  it 'sem sucesso' do
    s = Supplier.create!(corp_name: 'ACM LTDA', brand_name: 'ACME', regist_number:'4344721600',
                    full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', 
                    email: 'contato@acme.com')
      s.save

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACM LTDA'
    click_on 'Editar'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Atualizar Fornecedor'

    expect(page).to have_content 'Não foi possível atualizar o fornecedor'
  end
end
