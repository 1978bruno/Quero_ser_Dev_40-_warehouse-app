require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'Falso quando o nome estiver vazio' do
        warehouse = Warehouse.new(name:'', code:'Rio', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        result = warehouse.valid?

        expect(result).to eq false
      end
      it 'Falso quando o código estiver vazio' do
        warehouse = Warehouse.new(name:'Rio', code:'', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        result = warehouse.valid?

        expect(result).to eq false
      end
      it 'Falso quando a cidade estiver vazio' do
        warehouse = Warehouse.new(name:'Rio', code:'Rio', address: '',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        result = warehouse.valid?

        expect(result).to eq false
      end
      it 'Falso quando a área estiver vazio' do
        warehouse = Warehouse.new(name:'Rio', code:'Rio', address: 'Endereço',
                                  cep: '', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        result = warehouse.valid?

        expect(result).to eq false
      end
      it 'Falso quando o CEP estiver vazio' do
        warehouse = Warehouse.new(name:'Rio', code:'Rio', address: 'Endereço',
                                  cep: '25000-000', city: '', area: 1000,
                                  description: 'Alguma descrição')

        result = warehouse.valid?

        expect(result).to eq false
      end
      it 'Falso quando a descrição estiver vazio' do
        warehouse = Warehouse.new(name:'Rio', code:'Rio', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: '',
                                  description: 'Alguma descrição')

        result = warehouse.valid?

        expect(result).to eq false
      end
      it 'Falso quando o endereço estiver vazio' do
        warehouse = Warehouse.new(name:'Rio', code:'Rio', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: '')

        result = warehouse.valid?

        expect(result).to eq false
      end
    end
    it 'Falso quando o código já tiver sido usado' do
      first_warehouse = Warehouse.create(name:'RIO', code:'Rio', address: 'Endereço',
                                      cep: '25000-000', city: 'Rio', area: 1000,
                                      description: 'Alguma descrição')
      second_warehouse = Warehouse.create(name:'NIKITY', code:'Rio', address: 'Avenida',
                                      cep: '36000-000', city: 'Niteroi', area: 3000,
                                      description: 'Valor aleaório')
      
      result = second_warehouse.valid?

      expect(result).to eq false
    end
  end
end
