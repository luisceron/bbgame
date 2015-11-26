class CreatePredPredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.references :comp_competitions, :users
      t.timestamps
    end
  end
end
