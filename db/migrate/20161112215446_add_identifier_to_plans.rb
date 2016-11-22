class AddIdentifierToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :identifier, :string
  end
end
