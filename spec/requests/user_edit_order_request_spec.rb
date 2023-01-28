require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o responsável' do 
    bruno = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    joao = User.create!(name: 'João', email:'joao@email.com', password:'password')
    warehouse = Warehouse.create!(name: 'SDU', code: 'SDU2', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Samsung Eletronics LTDA', brand_name: 'Samsung', 
                                regist_number:'4344721600', full_addr: 'Av. das Palmas, 100', 
                                city: 'Bauru', state: 'SP', email: 'contato@samsung.com')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, 
                                estimated_delivery_date: 1.day.from_now)
    
    login_as(bruno)
    patch(order_path(order.id), params: { order: { supplier_id: 3 }})

    expect(response).to redirect_to(root_path)
  end
end