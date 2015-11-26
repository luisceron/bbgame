# encoding: utf-8
feature "team feature", :type => :feature do

  let(:team){create(:team_team)}

  let(:user) {create :user_user_admin}

  let(:valid_attributes) {
    attributes_for(:team_team)
  }

  before{ 
    sign_in_with(user.email, user.password)
  }

  scenario "listing teams" do
    visit team_teams_path
    expect(page).to have_content("Novo Time")
  end

  scenario "creating a new team" do
    visit new_team_team_path
    expect(page).to have_button("Cadastrar")
  end

  scenario "showing team" do
    visit "/team/teams/#{team.id}" 
    expect(page).to have_content("Editar")
  end

  scenario "updating team" do
    visit "/team/teams/#{team.id}/edit" 
    select 'Brasil', :from => 'País'
    click_button "Atualizar"
    expect(page).to have_content("Time atualizado com sucesso")
    expect(page).to have_content("Novo Time")
  end
  
  scenario "destroying a team" do
    Team::Team.create! valid_attributes
    visit team_teams_path
    click_on "Apagar"
    expect(page).to have_content("Time removido com sucesso")
    expect(page).to have_content("Novo Time")
  end
end
