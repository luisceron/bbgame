# encoding: utf-8
feature "competition feature", :type => :feature do

  let(:competition){create(:comp_competition, teams_added: true)}

  let(:user) {create :user_user_admin}

  let(:valid_attributes) {
    attributes_for(:comp_competition)
  }

  before{ 
    sign_in_with(user.email, user.password)
  }

  scenario "listing competitions" do
    visit comp_competitions_path
    expect(page).to have_content("Nova Competição")
  end

  scenario "creating a new competition" do
    visit new_comp_competition_path
    expect(page).to have_button("Salvar")
  end

  scenario "showing competition" do
    visit "/comp/competitions/#{competition.id}" 
    expect(page).to have_content("Editar")
  end

  scenario "updating competition" do
    visit "/comp/competitions/#{competition.id}/edit" 
    fill_in "Nome", with: "New Name"
    click_button "Salvar"
    expect(page).to have_content("Competição atualizada com sucesso.")
    expect(page).to have_content("Editar")
  end
  
  scenario "destroying a Competition" do
    Comp::Competition.create! valid_attributes
    visit comp_competitions_path
    click_on "Apagar"
    expect(page).to have_content("Competição removida com sucesso.")
    expect(page).to have_content("Nova Competição")
  end

  scenario "trying to select teams again" do
    visit comp_competition_add_teams_path(competition_id: competition.id)
    expect(current_path).to eql("/pt-BR/comp/competitions/#{competition.id}")
  end

  scenario "visit ranking" do
    visit comp_competition_ranking_path(competition_id: competition.id)
    expect(page).to have_content("Ranking")
  end

  scenario "setting post competition" do
    Comp::Competition.create! valid_attributes
    visit comp_competitions_path
    expect(page).to have_content("Submeter")
    click_on "Submeter"
    expect(page).to have_content("Competitição submetida com sucesso")
  end

  scenario "setting started competition" do
    Comp::Competition.create! valid_attributes
    visit comp_competitions_path
    expect(page).to have_content("Iniciar")
    click_on "Iniciar"
    expect(page).to have_content("Competição inicializada com sucesso")
  end
end
