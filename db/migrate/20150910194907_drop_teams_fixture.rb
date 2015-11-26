class DropTeamsFixture < ActiveRecord::Migration
  def up
    drop_table :teams_fixtures
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
