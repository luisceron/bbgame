# encoding: utf-8
feature "fixture feature", :type => :feature do

  let(:team1){create(:team_team)}
  
  let(:team2){create(:team_team)}

  let(:competition){create(:comp_competition, teams_added: true)}

  let(:round){create(:comp_round, competition_id: competition.id)}

  let(:fixture){create(:comp_fixture, round_id: round.id, team1_id: team1.id,
        team2_id: team2.id, result_team1: nil, result_team2: nil)}

  let(:user) {create :user_user_admin}

  let(:valid_attributes) {{
    round_id: round.id,
    team1_id: team1.id,
    team2_id: team2.id,
    result_team1: 2,
    result_team2: 2,
    date: "23/01/2010",
    hour: "10:00",
    local: "local"
  }}

  before{ 
    sign_in_with(user.email, user.password)
  }

  scenario "creating a new fixtures" do
    visit new_comp_round_fixture_path(round_id: round.id)
    expect(page).to have_button("Cadastrar")
  end

  scenario "updating fixture" do
    visit "/comp/fixtures/#{fixture.id}/edit"
    fill_in "Data", with: "30/05/2005"
    click_button "Atualizar"
    expect(page).to have_content("Jogo atualizado com sucesso.")
    expect(page).to have_content("Adicionar Jogo")
  end
  
  scenario "destroying a fixture" do
    Comp::Fixture.create! valid_attributes
    visit "/comp/rounds/#{round.id}"
  end

end
