require 'rails_helper'

RSpec.describe Team::Team, type: :model do
  
  let(:team){create(":team_team")}

  context "validating team" do

    it "must have a name" do
      expect(subject).to validate_presence_of(:name)
    end

    it "must have a country" do
      expect(subject).to validate_presence_of(:country)
    end    
  end
end
