class CreateCompFixtures < ActiveRecord::Migration
  def change
    create_table :comp_fixtures do |t|

      t.timestamps
    end
  end
end
