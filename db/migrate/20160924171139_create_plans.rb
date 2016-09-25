class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.string :duration
      t.string :description
      t.integer :subscription_id

      t.timestamps null: false
    end
  end
end
