module Features
  module SessionHelper
    def sign_in_with(email, password)
      visit root_path
      fill_in "E-mail", with: email
      fill_in "Senha", with: password
      click_button "Entrar"
    end
  end
end
