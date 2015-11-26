require 'rails_helper'

RSpec.describe User::UserSessionsController, type: :controller do

  let(:valid_attributes) {
    { email: 'userfactory1@bbgame.net', password: '123' }
  }

  let(:invalid_attributes) {{email: 'x', password: ''}}
  
  before(:each) do
  	create(:user_user)
  end

  let(:valid_session) { {} }

  describe "GET #new" do
    it "assigns a new user_session as @user_session" do
      get :new, {}, valid_session
      expect(assigns(:user_session)).to be_a(User::UserSession)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User::UserSession" do
		post :create, {:user_user_session => valid_attributes}, valid_session
        expect(session).to have_key(:user_id)
      end

      it "assigns a newly created user as @user_session" do
        post :create, {:user_user_session => valid_attributes}, valid_session
        expect(assigns(:user_session)).to be_a(User::UserSession)
      end

      it "redirects to root" do
        post :create, {:user_user_session => valid_attributes}, valid_session
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, {:user_user_session => invalid_attributes}, valid_session
        expect(assigns(:user_session)).to be_a(User::UserSession)
      end

      it "re-renders the 'new' template" do
        post :create, {:user_user_session => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      delete :destroy, {:id => :user_user.to_param}, valid_session
      expect(session).to_not have_key(":user_id")
    end

    it "redirects to the root" do
      delete :destroy, {:id => :user_user.to_param}, valid_session
      expect(response).to redirect_to(new_user_user_sessions_path)
    end
  end

end
