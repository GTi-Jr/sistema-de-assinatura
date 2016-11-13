class RemovePaypalandAddIuguToSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :paypal_customer_token, :string
    remove_column :subscriptions, :paypal_recurring_profile_token, :string
    add_column    :subscriptions, :iugu_payment_status, :string
  end
end
