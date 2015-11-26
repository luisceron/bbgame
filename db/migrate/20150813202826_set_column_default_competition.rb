class SetColumnDefaultCompetition < ActiveRecord::Migration
  def change
    change_column :comp_competitions, :teams_added, :boolean, default: false
  end
end
