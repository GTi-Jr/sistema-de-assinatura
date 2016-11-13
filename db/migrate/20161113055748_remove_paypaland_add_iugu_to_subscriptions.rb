class RemovePaypalandAddIuguToSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :paypal_customer_token
    remove_column :subscriptions, :paypal_recurring_profile_token
    add_column    :subscriptions, :iugu_status, :string
  end
end
