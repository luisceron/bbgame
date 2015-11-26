# encoding: utf-8
feature "User Profile", :type => :feature do

  let(:user) {create :user_user}

  before{ 
    sign_in_with(user.email, user.password)
    visit "/user/users/#{user.id}" 
  }

  scenario "expected on show" do
    expect(page).to have_content("Nome Completo")
    expect(page).to have_content("Apelido")
    expect(page).to have_content("E-mail")
    expect(page).to have_content("Nascimento")
  end

  scenario "click on edit" do
    click_link "Editar"
    expect(page).to have_button("Atualizar")
  end

  scenario "editing user profile" do
    click_link "Editar"
    fill_in "Cidade", with: "Passo Fundo"
    click_button "Atualizar"
    expect(page).to have_content("Usuário atualizado com Sucesso!")
    expect(page).to have_content("Passo Fundo")
  end

  scenario "require_no_authentication" do
    visit new_user_user_path
  end
end
