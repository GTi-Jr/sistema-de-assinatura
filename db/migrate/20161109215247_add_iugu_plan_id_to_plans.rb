class AddIuguPlanIdToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :iugu_plan_id, :string
  end
end
