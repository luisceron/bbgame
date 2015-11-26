# encoding: utf-8
feature "round feature", :type => :feature do
  let(:team1){create(:team_team)}
  let(:team2){create(:team_team)}
  let(:competition){create(:comp_competition, teams_added: true, number_teams: 2)}
  let(:round){create(:comp_round, competition_id: competition.id)}
  let(:fixture){create(:comp_fixture, round_id: round.id, team1_id: team1.id,
        team2_id: team2.id, result_team1: nil )}
  let(:fixture2){create(:comp_fixture, round_id: round.id, team1_id: team1.id,
        team2_id: team2.id, done: true )}
  let!(:pred_round){create(:pred_round, round_id: round.id)}

  let(:user) {create :user_user_admin}

  before{ 
    sign_in_with(user.email, user.password)
  }

  scenario "listing rounds" do
    visit comp_competition_rounds_path(competition_id: competition.id)
    expect(page).to have_content("Nova Rodada")
  end

  scenario "creating a new round" do
    visit new_comp_competition_round_path(competition_id: competition.id)
    expect(page).to have_button("Cadastrar")
  end

  scenario "showing round" do
    visit "/comp/rounds/#{round.id}" 
    expect(page).to have_content("Editar")
  end

  scenario "updating round" do
    visit "/comp/rounds/#{round.id}/edit" 
    select '2', :from => 'Rodada'
    click_button "Atualizar"
    expect(page).to have_content("Rodada atualizada com sucesso.")
    expect(page).to have_content("Editar")
  end
  
  scenario "Setting #set_round_done" do
    round.fixtures << fixture2
    visit "/comp/rounds/#{round.id}"
    click_link('Finalizar', match: :first)
    expect(page).to have_content("Rodada Finalizada")
  end

  scenario "Can't set #set_round_done because results are nil" do
    round.fixtures << fixture
    visit "/comp/rounds/#{round.id}"
    click_link('Finalizar', match: :first)
    expect(page).to have_content("Não é possível finalizar esta rodada")
  end

end
