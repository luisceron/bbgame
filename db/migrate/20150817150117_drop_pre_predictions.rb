class DropPrePredictions < ActiveRecord::Migration
  def up
    drop_table :pre_predictions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
