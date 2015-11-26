# encoding: utf-8
feature "Accessing the root logged", :type => :feature do
  
  let(:user) {create :user_user}

  before{ sign_in_with(user.email, user.password) }
  
  scenario "click on logo button" do
    click_link "BBGame"
    expect(page).to have_content("BBGame")
  end

  scenario "menu Competitions" do
    expect(page).to have_content("Competições")
  end

  # scenario "menu Group" do
  #   expect(page).to have_content("Group")
  # end

  scenario "click on Logout" do
    click_link "Sair"
    expect(page).to have_content("Logout efetuado com sucesso. Até logo!")
    expect(page).to have_content("Entrar")
  end

  scenario "click language" do
    click_link "Português"
    expect(page).to have_content("Idioma")
  end
 
end
