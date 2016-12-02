class AddDiscountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :discount, :boolean
  end
end
