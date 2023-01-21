class Supplier < ApplicationRecord
  validates :corp_name, :brand_name, :regist_number, :full_addr, :city, :state, :email, presence: true
  validates :regist_number, uniqueness: true
end
