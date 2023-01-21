require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')

    visit root_path
    click_on 'Rio'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Nome: Rio'
    expect(page).not_to have_content 'Código: SDU'
    expect(page).not_to have_content 'Cidade: Rio de Janeiro'
    expect(page).not_to have_content 'Avenida do aeroporto, 1000'
    expect(page).not_to have_content 'Área: 60000 m2'
    expect(page).not_to have_content 'CEP: 15000-000'
    expect(page).not_to have_content 'Galpão destinado para cargas internacionais'
  end
  it 'Não apaga outros galpões' do
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
      address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
      description: 'Galpão destinado para cargas internacionais')
    warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 80_000,
      address: 'Avenida tiradentes, 9999', cep: '31000-000', 
      description: 'Galpão destinado para cargas mineiras')

    visit root_path
    click_on 'Rio'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Rio'
    expect(page).to have_content 'Belo Horizonte'
  end
end