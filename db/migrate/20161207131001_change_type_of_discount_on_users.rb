class ChangeTypeOfDiscountOnUsers < ActiveRecord::Migration
  def change
    remove_column :users, :discount, :boolean
    add_column :users, :discount, :integer
  end
end
