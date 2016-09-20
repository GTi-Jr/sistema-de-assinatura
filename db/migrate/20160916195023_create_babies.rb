  class CreateBabies < ActiveRecord::Migration
  def change
    create_table :babies do |t|
      t.string :name
      t.boolean :born
      t.integer :months
      t.date :birthdate

      t.timestamps null: false
    end
  end
end
