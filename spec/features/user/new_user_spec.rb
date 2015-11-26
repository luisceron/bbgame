# encoding: utf-8
feature "Signing up", :type => :feature do
  scenario "filling up form" do
    visit new_user_user_path
    fill_in "Nome Completo", with: "CapybaraName"
    fill_in "Apelido", with: "Capybara"
    within("section") do
      fill_in "E-mail", with: "capybara@bbgame.net"
    end
    fill_in "Nascimento", with: "05/05/1995"
    fill_in "Cidade", with: "Erechim"
    fill_in "Telefone", with: "(54)3712-9999"
    fill_in "Celular", with: "(54)9172-9999"
    within("section") do
      fill_in "Senha", with: "senha123123"
    end
    fill_in "Confirme a senha", with: "senha123123"
    click_button "Cadastrar"
    expect(page).to have_content("Bem Vindo")
  end

  scenario "filling up form fail" do
    visit new_user_user_path
    click_button "Cadastrar"
    expect(page).to have_content("Não pode ficar em branco")
  end
end
