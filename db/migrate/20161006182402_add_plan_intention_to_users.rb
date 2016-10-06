class AddPlanIntentionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :plan_intention, :integer
  end
end
