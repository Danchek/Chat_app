class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nickname, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :sex, :string
    add_column :users, :location, :string
    add_column :users, :marital_status, :string
    add_column :users, :description, :text
  end
end
