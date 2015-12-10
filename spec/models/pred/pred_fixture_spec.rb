require 'rails_helper'

RSpec.describe Pred::PredFixture, type: :model do
  let(:team1){create(:team_team)}
  let(:team2){create(:team_team)}
  let(:fixture){create(:comp_fixture, team1_id: team1.id, team2_id: team2.id)}
  let(:pred_fixture){create(:pred_fixture, fixture_id: fixture.id)}

  context "user hits fixture" do
    it "points for a drawn prediction fixture when not filled" do
    	expect(Pred::PredFixture.calculate_points(fixture, pred_fixture)).to be(0)
    end

    it "calculating points for a drawn" do
      fixture.update_attributes(result_team1: 2, result_team2: 2)
    	pred_fixture.update_attributes( filled: true, pred_result_team1: 1,
                                      pred_result_team2: 1)
    	expect(Pred::PredFixture.calculate_points(fixture, pred_fixture)).to be(90)
    end

    it "calculating points, Team1 wins" do
      fixture.update_attributes(result_team1: 2, result_team2: 1)
    	pred_fixture.update_attributes( filled: true, pred_result_team1: 2,
                                      pred_result_team2: 1)
    	expect(Pred::PredFixture.calculate_points(fixture, pred_fixture)).to be(150)
    end

    it "calculating points, Team1 wins, user hits winner score" do
      fixture.update_attributes(result_team1: 2, result_team2: 1)
      pred_fixture.update_attributes( filled: true, pred_result_team1: 2,
                                      pred_result_team2: 0)
      expect(Pred::PredFixture.calculate_points(fixture, pred_fixture)).to be(100)
    end

    it "calculating points, Team1 wins, user hits loser score" do
      fixture.update_attributes(result_team1: 2, result_team2: 1)
      pred_fixture.update_attributes( filled: true, pred_result_team1: 3,
                                      pred_result_team2: 1)
      expect(Pred::PredFixture.calculate_points(fixture, pred_fixture)).to be(95)
    end

    it "calculating points, Team2 wins" do
      fixture.update_attributes(result_team1: 1, result_team2: 2)
    	pred_fixture.update_attributes( filled: true, pred_result_team1: 1,
                                      pred_result_team2: 2)
    	expect(Pred::PredFixture.calculate_points(fixture, pred_fixture)).to be(150)
    end

    it "calculating points, Team2 wins, user hits winner score" do
      fixture.update_attributes(result_team1: 1, result_team2: 2)
      pred_fixture.update_attributes( filled: true, pred_result_team1: 0,
                                      pred_result_team2: 2)
      expect(Pred::PredFixture.calculate_points(fixture, pred_fixture)).to be(100)
    end

    it "calculating points, Team2 wins, user hits loser score" do
      fixture.update_attributes(result_team1: 1, result_team2: 2)
      pred_fixture.update_attributes( filled: true, pred_result_team1: 1,
                                      pred_result_team2: 3)
      expect(Pred::PredFixture.calculate_points(fixture, pred_fixture)).to be(95)
    end

    it "service to check if fixture is out of date" do
    	fixture.update_attributes(date: Date.today, hour: Time.now.in_time_zone.hour.to_s)
      pred_fix = pred_fixture
    	Pred::PredFixture.out_of_date_fixture
    end
  end

  context "user doesn't hit the fixture" do
    it "calculating points, Team1 wins" do
      fixture.update_attributes(result_team1: 2, result_team2: 1)
      pred_fixture.update_attributes( filled: true, pred_result_team1: 1,
                                      pred_result_team2: 2)
      expect(Pred::PredFixture.calculate_points(fixture, pred_fixture)).to be(0)
    end

    it "calculating points, Team2 wins" do
      fixture.update_attributes(result_team1: 1, result_team2: 2)
      pred_fixture.update_attributes( filled: true, pred_result_team1: 2,
                                      pred_result_team2: 1)
      expect(Pred::PredFixture.calculate_points(fixture, pred_fixture)).to be(0)
    end

    it "calculating points fow drawn" do
      fixture.update_attributes(result_team1: 1, result_team2: 1)
      pred_fixture.update_attributes( filled: true, pred_result_team1: 2,
                                      pred_result_team2: 1)
      expect(Pred::PredFixture.calculate_points(fixture, pred_fixture)).to be(0)
    end
  end

end
