class RenameTableCompRounds < ActiveRecord::Migration
  def self.up
    rename_table :comp_rounds, :rounds
  end

 def self.down
    rename_table :rounds, :comp_rounds
 end
end
