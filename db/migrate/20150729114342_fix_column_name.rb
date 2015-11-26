class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :comp_competitions, :type, :kind
  end
end
