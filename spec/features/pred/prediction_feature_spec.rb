# encoding: utf-8
feature "prediction feature", :type => :feature do
  let(:user){create(:user_user)}
  let(:team1){create(:team_team)}
  let(:team2){create(:team_team)}
  let(:competition){create(:comp_competition)}
  let(:competition2){create(:comp_competition)}
  let!(:round){create(:comp_round, competition_id: competition.id)}
  let!(:fixture){create(:comp_fixture, team1_id: team1.id, team2_id: team2.id)}
  let(:prediction){create(:pred_prediction, user_id: user.id, 
  	competition_id: competition.id)}
  let(:prediction2){create(:pred_prediction, user_id: user.id,
    competition_id: competition2.id)}

  before{ 
    sign_in_with(user.email, user.password)
  }

  scenario "getting ranking" do
  	visit "/pred/predictions/#{prediction.id}/pred_ranking"
  end

  scenario "there's no PredRounds" do
    visit "/pred/predictions/#{prediction2.id}/assign_fixtures"
  end
    
  scenario "showing Pred::Fixtures with directions" do
    pred_round = prediction.pred_rounds.first
    visit "/pred/predictions/#{prediction.id}/assign_fixtures?d=1&pred_round_id=#{pred_round.id}"
    visit "/pred/predictions/#{prediction.id}/assign_fixtures?d=2&pred_round_id=#{pred_round.id}"
    visit "/pred/predictions/#{prediction.id}/assign_fixtures?d=3&pred_round_id=#{pred_round.id}"
  end

  scenario "showing and updating Pred::Fixtures at first time" do
    visit "/pred/predictions/#{prediction.id}/assign_fixtures"
    round.update_attributes(done: true)
    visit "/pred/predictions/#{prediction.id}/assign_fixtures"
  end

end
