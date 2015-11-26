class AddColumnToRounds < ActiveRecord::Migration
  def change
  	add_column :rounds, :done, :boolean
  end
end
