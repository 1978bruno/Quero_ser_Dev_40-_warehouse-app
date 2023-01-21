require  'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da pagina de detalhes de um galão' do
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                description: 'Galpão destinado para cargas internacionais')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'

    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field('Nome', with: 'Rio')
    expect(page).to have_field('Código', with: 'SDU')
    expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
    expect(page).to have_field('Área', with: '60000')
    expect(page).to have_field('Endereço', with: 'Avenida do aeroporto, 1000')
    expect(page).to have_field('CEP', with: '15000-000')
    expect(page).to have_field('Descrição', with: 'Galpão destinado para cargas internacionais')
    
  end
  it 'com sucesso' do
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    fill_in 'Nome', with: 'Galpão internacional'
    fill_in 'Área', with: 20000
    fill_in 'CEP', with: '16000-000'
    fill_in 'Endereço', with: 'Av. dos galpões, 501'
    click_on 'Atualizar Galpão'

    expect(page).to have_content 'Galpão atualizado com sucesso'
    expect(page).to have_content 'Nome: Galpão internacional'
    expect(page).to have_content 'Endereços: Av. dos galpões, 501'
    expect(page).to have_content 'Área: 20000 m2'
    expect(page).to have_content 'CEP: 16000-000'
  end
  it 'com sucesso' do
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Área', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Atualizar Galpão'

    expect(page).to have_content 'Não foi possível atualizar o galpão'
  end
end
