class RenameIuguPlanIdToIuguPlanInPlans < ActiveRecord::Migration
  def change
    rename_column :plans, :iugu_plan_id, :iugu_id
  end
end
