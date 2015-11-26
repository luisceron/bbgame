class AddFieldToCompetition < ActiveRecord::Migration
  def change
    add_column :comp_competitions, :teams_added, :boolean
  end
end
