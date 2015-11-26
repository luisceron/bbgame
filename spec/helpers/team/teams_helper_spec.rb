require 'rails_helper'

RSpec.describe Team::TeamsHelper, type: :helper do
  describe "Team helper" do
    let(:team) {create :team_team}
    
    it "display flag from Teams" do
      display_flag_from_team(team.id, 100, 100, "classe")
    end

    it "get team short_name" do
      result = get_team_short_name(team.id)
      expect(result).to eq(team.short_name)
    end
  end
end
