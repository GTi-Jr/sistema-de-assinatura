class AddMainToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :main, :boolean, default: false
  end
end
