class ChangeNameTablePreRounds < ActiveRecord::Migration
  def self.up
    rename_table :pred_pred_rounds, :pred_rounds
  end

 def self.down
    rename_table :pred_rounds, :pred_pred_rounds
 end
end
