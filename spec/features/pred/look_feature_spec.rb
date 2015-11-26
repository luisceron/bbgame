# encoding: utf-8
feature "look feature", :type => :feature do
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

  scenario "there's no PredRounds" do
    visit "/pred/look/look_fixtures?prediction_id=#{prediction.id}"
  end
    
  scenario "look User Fixtures with directions" do
    pred_round = prediction.pred_rounds.first
    visit "/pred/look/look_fixtures?prediction_id=#{prediction.id}&d=1&pred_round_id=#{pred_round.id}"
    visit "/pred/look/look_fixtures?prediction_id=#{prediction.id}&d=2&pred_round_id=#{pred_round.id}"
    visit "/pred/look/look_fixtures?prediction_id=#{prediction.id}&d=3&pred_round_id=#{pred_round.id}"
  end

  scenario "look User Fixtures at first time" do
    visit "/pred/look/look_fixtures?prediction_id=#{prediction.id}"
    pred_round = prediction.pred_rounds.first
    round.update_attributes(done: true)
    visit "/pred/look/look_fixtures?prediction_id=#{prediction.id}&"
  end

end
