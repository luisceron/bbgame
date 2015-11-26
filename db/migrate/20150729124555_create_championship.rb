class CreateChampionship < ActiveRecord::Migration
  def self.up
    create_table :championships do |t|
      t.references :comp_competitions, :team_teams
      t.timestamps
    end
  end

  def self.down
    drop_table :championships
  end
end
