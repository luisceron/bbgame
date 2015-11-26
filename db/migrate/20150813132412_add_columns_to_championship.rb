class AddColumnsToChampionship < ActiveRecord::Migration
  def change
    add_column :championships, :position, :integer
    add_column :championships, :team_name, :string
    add_column :championships, :points, :integer
    add_column :championships, :played, :integer
    add_column :championships, :won, :integer
    add_column :championships, :drawn, :integer
    add_column :championships, :lost, :integer
    add_column :championships, :goals_for, :integer
    add_column :championships, :goals_against, :integer
    add_column :championships, :goals_difference, :integer
  end
end
