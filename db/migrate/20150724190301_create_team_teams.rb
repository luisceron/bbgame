class CreateTeamTeams < ActiveRecord::Migration
  def change
    create_table :team_teams do |t|
      t.string :name
      t.string :country

      t.timestamps
    end
  end
end
