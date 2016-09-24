class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.date :canceled_on
      t.string :subscription_code, unique: true
      t.integer :user_id
      t.integer :plan_id

      t.timestamps null: false
    end
  end
end
