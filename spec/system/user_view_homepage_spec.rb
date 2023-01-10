require 'rails_helper'

describe 'Usuário visita tela inicial' do
    it 'e vê o nome do app' do
        # arrange

        # act
        visit('/')

        #assert
        expect(page).to have_content('Galpões & Estoque')

    end
end