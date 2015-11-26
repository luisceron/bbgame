class DropPredPredictions < ActiveRecord::Migration
  def up
    drop_table :pred_predictions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
