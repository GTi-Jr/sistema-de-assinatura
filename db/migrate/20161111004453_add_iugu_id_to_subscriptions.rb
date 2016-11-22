class AddIuguIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :iugu_id, :string
    remove_column :users, :subscription_id
  end
end
