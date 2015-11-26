class AddNewColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :birth, :date
    add_column :users, :gender, :boolean
    add_column :users, :city, :string
    add_column :users, :phone, :string
    add_column :users, :mobile, :string
  end
end
