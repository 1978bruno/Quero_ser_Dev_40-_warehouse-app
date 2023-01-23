require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe '#description' do
    it 'Exie o nome e o do email' do
      u = User.new(name: 'Julia Almeida', email: 'julia@yahoo.com')
      
      result = u.description()

      expect(result).to eq('Julia Almeida - julia@yahoo.com')
    end
  end
end
