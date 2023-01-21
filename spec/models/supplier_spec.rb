require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'Falso quando o Razão Social estiver vazio' do
        supplier = Supplier.new(corp_name: '', brand_name: 'ACME', regist_number:'4344721600',
          full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        result = supplier.valid?

        expect(result).to eq false
      end
      it 'Falso quando o nome fantasia estiver vazio' do
        supplier = Supplier.new(corp_name: 'ACM LTDA', brand_name: '', regist_number:'4344721600',
          full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        result = supplier.valid?

        expect(result).to eq false
      end
      it 'Falso quando o CNPJ estiver vazio' do
        supplier = Supplier.new(corp_name: 'ACM LTDA', brand_name: 'ACME', regist_number:'',
          full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        result = supplier.valid?

        expect(result).to eq false
      end
      it 'Falso quando o endereço estiver vazio' do
        supplier = Supplier.new(corp_name: 'ACM LTDA', brand_name: 'ACME', regist_number:'4344721600',
          full_addr: '', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        result = supplier.valid?

        expect(result).to eq false
      end
      it 'Falso quando a cidade estiver vazio' do
        supplier = Supplier.new(corp_name: 'ACM LTDA', brand_name: 'ACME', regist_number:'4344721600',
          full_addr: 'Av. das Palmas, 100', city: '', state: 'SP', email: 'contato@acme.com')

        result = supplier.valid?

        expect(result).to eq false
      end
      it 'Falso quando o estado estiver vazio' do
        supplier = Supplier.new(corp_name: 'ACM LTDA', brand_name: 'ACME', regist_number:'4344721600',
          full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: '', email: 'contato@acme.com')

        result = supplier.valid?

        expect(result).to eq false
      end
      it 'Falso quando o email estiver vazio' do
        supplier = Supplier.new(corp_name: 'ACM LTDA', brand_name: 'ACME', regist_number:'4344721600',
          full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', email: '')

        result = supplier.valid?

        expect(result).to eq false
      end
    end
    it 'Falso quando o código já tiver sido usado' do
      first_supplier = Supplier.create(corp_name: 'ACM LTDA', brand_name: 'ACME', regist_number:'4344721601 ',
                                      full_addr: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', 
                                      email: 'contato@acme.com')
      second_supplier = Supplier.create(corp_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', 
                                      regist_number:'4344721601', full_addr: 'Torre da Industria, 1', 
                                      city: 'Teresina', state: 'PI', email: 'venda@acme.com')
      
      result = second_supplier.valid?

      expect(result).to eq false
    end
  end
end
