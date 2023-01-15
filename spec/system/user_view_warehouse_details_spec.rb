require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do
  it 'e vê informações adicionais' do
    #Arrange
    w = Warehouse.new(name: 'Aeroporto de SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                    address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
    w.save

    #act
    visit('/')
    click_on('Aeroporto de SP')

    #assert
    expect(page).to have_content('Galpão GRU')
    expect(page).to have_content('Nome: Aeroporto de SP')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Área: 100000 m2')
    expect(page).to have_content('Endereços: Avenida do aeroporto, 1000')
    expect(page).to have_content('CEP: 15000-000')
    expect(page).to have_content('Galpão destinado para cargas internacionais')
  end
end