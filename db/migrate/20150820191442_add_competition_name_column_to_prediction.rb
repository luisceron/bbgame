class AddCompetitionNameColumnToPrediction < ActiveRecord::Migration
  def change
  	add_column :predictions, :competition_name, :string
  end
end
