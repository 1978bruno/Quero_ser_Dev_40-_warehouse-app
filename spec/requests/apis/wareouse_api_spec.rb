require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses/1' do
    it 'sucesso' do
      warehouse = Warehouse.create!(name: 'SDU', code: 'SDU2', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
              
      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq 'SDU'
      expect(json_response['code']).to eq 'SDU2'
    end
  end
end