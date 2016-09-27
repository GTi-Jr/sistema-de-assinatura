class ChangeFieldsInPlan < ActiveRecord::Migration
  def change
    add_column :plans, :price, :decimal, :precision => 8, :scale => 2
  end
end
