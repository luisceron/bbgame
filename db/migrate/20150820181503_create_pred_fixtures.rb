class CreatePredFixtures < ActiveRecord::Migration
  def change
    create_table :pred_fixtures do |t|
      t.integer :pred_round_id
      t.integer :pred_result_team1
      t.integer :pred_result_team2
      t.timestamps
    end
    add_index :pred_fixtures, :pred_round_id
  end
end
