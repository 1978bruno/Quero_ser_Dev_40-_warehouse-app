class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :corp_name
      t.string :brand_name
      t.integer :regist_number
      t.string :full_addr
      t.string :city
      t.string :state
      t.string :email

      t.timestamps
    end
  end
end
