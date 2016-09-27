class ChangePlanPriceToFloat < ActiveRecord::Migration
  def change
    change_column :plans, :price, :float
  end
end
