class RenameTableCompFixtures < ActiveRecord::Migration
  def self.up
    rename_table :comp_fixtures, :fixtures
  end

 def self.down
    rename_table :fixtures, :comp_fixtures
 end
end
