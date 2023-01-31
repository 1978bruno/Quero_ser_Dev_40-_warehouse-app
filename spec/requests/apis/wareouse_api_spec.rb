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
      expect(json_response.keys).not_to include "created_at"
      expect(json_response.keys).not_to include "updated_at"
    end
    it 'falha se a warehouse não achada' do
      

      get "/api/v1/warehouses/999999999"
      
      expect(response.status).to eq 404
    end
  end
  context 'GET /api/v1/warehouses' do
    it 'lista todos os galpõespor nome' do
      warehouse = Warehouse.create!(name: 'SDU', code: 'SDU2', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
      warehouse = Warehouse.create!(name: 'CFN', code: 'CFN2', city: 'Belo Horizonte', area: 60_000,
                                    address: 'Avenida do aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')

      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[1]['name']).to eq 'SDU'
      expect(json_response[0]['name']).to eq 'CFN'
    end
    it 'retorna vazio se não tiver galpões' do

      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end
end