require 'rails_helper'

RSpec.describe Comp::Fixture, type: :model do
  let(:fixture){create(:comp_fixture)}

  context "validating a fixture" do
    it "must have a date" do
      expect(subject).to validate_presence_of(:date)
    end

    it "must have a hour" do
      expect(subject).to validate_presence_of(:hour)
    end
  end	
end
