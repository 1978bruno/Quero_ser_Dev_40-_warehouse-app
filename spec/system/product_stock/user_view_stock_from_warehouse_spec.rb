require 'rails_helper'

describe 'Usuário vê estoque' do
  it 'na tela do galpão' do
    user = User.create!(email:'bruno@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                    address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', regist_number:'4344721600',
                                full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', 
                                email: 'contato@samsung.com')
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, 
                          estimated_delivery_date: 1.day.from_now)
    product_tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depht: 10, 
                                      sku: 'TV21-SAMSU-XPTO90', supplier: supplier)
    product_sb = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, 
                                      depht:20, sku: 'SOU71-SAMSU-NOIZ77', supplier: supplier)
    product_nb = ProductModel.create!(name: 'Notebook i5 16GB RAM', weight: 2000, width: 40, height: 9, 
                                      depht:20, sku: 'NOTEI5-SAMSU-TLI99', supplier: supplier)
    3.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv)}
    2.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: product_nb)}

    login_as(user)
    visit root_path
    click_on 'Rio'

    within('section#stock_products') do
      expect(page).to have_content 'Itens em estoque'
      expect(page).to have_content '3 x TV21-SAMSU-XPTO90'
      expect(page).to have_content '2 x NOTEI5-SAMSU-TLI99'
      expect(page).not_to have_content 'SOU71-SAMSU-NOIZ77'
    end

  end
  it 'e dar baixa em um item' do
    user = User.create!(email:'bruno@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                    address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                    description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', regist_number:'4344721600',
                                full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', 
                                email: 'contato@samsung.com')
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, 
                          estimated_delivery_date: 1.day.from_now)
    product_tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depht: 10, 
                                      sku: 'TV21-SAMSU-XPTO90', supplier: supplier)
    2.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv)}
              
    login_as(user)
    visit root_path
    click_on 'Rio'
    select 'TV21-SAMSU-XPTO90', from: 'Item para Saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço Destino', with: 'Rua das Palmeiras, 100 - Campinas - São Paulo'
    click_on 'Confirmar Retirada'

    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '1 x TV21-SAMSU-XPTO90'

  end
end