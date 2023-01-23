require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    User.create!(email:'bruno@email.com', password:'password')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'bruno@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'bruno@email.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso'
  end
  it 'faz logout' do
    User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'bruno@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'

    within('nav') do
      expect(page).not_to have_button 'Sair'
      expect(page).to have_link 'Entrar'
      expect(page).not_to have_content 'bruno@email.com'
    end
  end
end