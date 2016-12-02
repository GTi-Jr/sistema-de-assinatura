class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :title
      t.text :body
      t.integer :to
      t.integer :to

      t.timestamps null: false
    end
  end
end
