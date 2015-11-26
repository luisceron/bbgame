class RemoveDoneFromPredRounds < ActiveRecord::Migration
  def change
  	remove_column :pred_rounds, :done
  end
end
