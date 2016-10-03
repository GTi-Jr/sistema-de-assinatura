class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.float :amount
      t.integer :quantity
      t.date :expiry_date

      t.timestamps null: false
    end
  end
end
