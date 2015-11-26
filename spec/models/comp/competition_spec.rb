require 'rails_helper'

RSpec.describe Comp::Competition, type: :model do
  let(:competition){create(":comp_competition")}

  context "validating competition" do

    it "must have a name" do
      expect(subject).to validate_presence_of(:name)
    end

    it "must have a kind" do
      expect(subject).to validate_presence_of(:kind)
    end

    it "must have a number_teams" do
      expect(subject).to validate_presence_of(:number_teams)
    end

    it "must have a place" do
      expect(subject).to validate_presence_of(:place)
    end
  end
end
