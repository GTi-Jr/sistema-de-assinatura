class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :customer_id,:string
    add_column :users, :subscription_id,:string
  end
end
