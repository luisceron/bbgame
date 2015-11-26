class ChangeDefaultValueChampionships < ActiveRecord::Migration
  def change
    change_column :championships, :position, :integer, default: 1
	change_column :championships, :points, :integer, default: 0
	change_column :championships, :played, :integer, default: 0
	change_column :championships, :won, :integer, default: 0
	change_column :championships, :drawn, :integer, default: 0
	change_column :championships, :lost, :integer, default: 0
	change_column :championships, :goals_for, :integer, default: 0
	change_column :championships, :goals_against, :integer, default: 0
	change_column :championships, :goals_difference, :integer, default: 0
  end

end
