class ChangeCompCompetitionsTableName < ActiveRecord::Migration
  def self.up
  	rename_table :comp_competitions, :competitions
  end

  def self.down
  	rename_table :competitions, :comp_competitions
  end
end
