require 'rails_helper'

RSpec.describe Comp::Round, type: :model do
  let(:round){create(:comp_round)}

  context "validating a round" do
    it "must have a number" do
      expect(subject).to validate_presence_of(:number_round)
    end
  end
end
