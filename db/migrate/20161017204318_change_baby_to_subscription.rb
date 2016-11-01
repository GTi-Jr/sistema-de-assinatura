class ChangeBabyToSubscription < ActiveRecord::Migration
  def change
    rename_column :babies, :user_id, :subscription_id
  end
end
