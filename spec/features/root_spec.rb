# encoding: utf-8
feature "Accessing the root", :type => :feature do
  
  before{ visit root_path}
  let(:user) {create :user_user}

  scenario "click on logo button" do
    click_link "BBGame"
    expect(page).to have_content("BBGame")
  end

  scenario "logging in" do
    fill_in 'E-mail', :with => user.email
    fill_in 'Senha', :with => user.password
    click_button "Entrar"
    expect(page).to have_content("Login efetuado com sucesso!")
    expect(page).to have_content("Sair")
  end

  scenario "logging in fail" do
    fill_in 'E-mail', :with => user.email
    fill_in 'Senha', :with => ""
    click_button "Entrar"
    expect(page).to have_content("Usuário ou senha inválidos")
  end

  scenario "click on Register" do
    click_link "Registrar"
    expect(page).to have_content("Registro")
  end

  scenario "click language" do
    click_link "Inglês"
    expect(page).to have_content("Language")
  end

end
