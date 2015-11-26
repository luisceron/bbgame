class CreateCompRounds < ActiveRecord::Migration
  def change
    create_table :comp_rounds do |t|

      t.timestamps
    end
  end
end
