class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :sex, :string
    add_column :users, :birthdate, :date
    add_column :users, :cpf, :string
    add_column :users, :rg, :string
    add_column :users, :street, :string
    add_column :users, :phone, :string
    add_column :users, :zipcode, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
  end
end
