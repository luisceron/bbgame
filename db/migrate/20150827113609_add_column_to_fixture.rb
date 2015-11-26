class AddColumnToFixture < ActiveRecord::Migration
  def change
  	add_column :fixtures, :done, :boolean
  end
end
