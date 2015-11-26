class CreateCompCompetitions < ActiveRecord::Migration
  def change
    create_table :comp_competitions do |t|
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
