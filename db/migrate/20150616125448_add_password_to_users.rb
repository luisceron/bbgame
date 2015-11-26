class AddPasswordToUsers < ActiveRecord::Migration
  def change
    # add_column table_name, :column_name, :column_type
    add_column :users, :password, :string
  end
end
