class CreatePredPredRounds < ActiveRecord::Migration
  def change
    create_table :pred_pred_rounds do |t|

      t.timestamps
    end
  end
end
