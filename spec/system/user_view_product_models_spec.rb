require 'rails_helper'
describe 'Usuário vê modelos de produtos' do
  it 'se estiver autenticado' do


    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq new_user_session_path
  end
end

describe 'Usuário vê modelos de produtos' do
   it 'a partir do menu' do
    user = User.create!(email:'bruno@email.com', password:'password')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq product_models_path
  end
  it 'com sucesso' do
    user = User.create!(email:'bruno@email.com', password:'password')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', regist_number:'4344721600',
                              full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', 
                              email: 'contato@samsung.com')
    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depht: 10, 
                        sku: 'TV21-SAMSU-XPTO90', supplier: supplier)
    ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depht:20, 
                        sku: 'SOU71-SAMSU-NOIZ77', supplier:)

    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV21-SAMSU-XPTO90'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'SOU71-SAMSU-NOIZ77'
    expect(page).to have_content 'Samsung'
  end
  it 'e não existem produtos cadastrados' do
    user = User.create!(email:'bruno@email.com', password:'password')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'Modelos de Produtos'

    expect(page).to have_content 'Nenhum modelo de produto cadastrado'
  end

end