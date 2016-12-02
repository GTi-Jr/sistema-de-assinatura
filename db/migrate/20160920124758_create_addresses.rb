class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :zipcode
      t.string :city
      t.string :state
      t.string :number
      t.integer :user_id

      t.timestamps null: false
    end 

    remove_column :users, :street, :string
    remove_column :users, :zipcode, :string
    remove_column :users, :city, :string
    remove_column :users, :state, :string
    remove_column :users, :number, :string
  end
end
