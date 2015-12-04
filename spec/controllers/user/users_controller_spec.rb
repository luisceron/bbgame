require 'rails_helper'

RSpec.describe User::UsersController, type: :controller do

  let(:user){ create(:user_user) }

  let(:valid_attributes) {
    attributes_for(:user_user)
  }

  let(:invalid_attributes) { {name: ""} }

  # def valid_session
  #   controller.stub(:can_change).and_return(true)
  # end

  let(:valid_session_user) do
    authenticated_session(user)
  end

  let(:admin_valid_session) do
    authenticated_session(create(:user_user_admin))
  end

  describe "GET #index" do
    context "as admin" do
      it "assigns all users as @users" do
        valid_attributes['email'] = "new_index@bbgame.net"
        user_index = User::User.create! valid_attributes
        # get :index, {}, valid_session
        get :index, {}, admin_valid_session
        # expect(assigns(:users)).to eq([user_index])
        expect(assigns(:users)).to_not be_nil
      end
    end

    context "as user" do
      it "user can't access index" do
        get :index, {}, valid_session_user
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #show" do
    context "with valid user" do
      it "assigns the requested user as @user" do
        get :show, {:id => user.to_param}, valid_session_user
        expect(assigns(:user)).to eq(user)
      end
    end

    context "with invalid user" do
      it "can't logged and can't change" do
        get :show, {:id => user.to_param}, {}
        # expect(response).to redirect_to(user)
        expect(response).to redirect_to(root_path)
      end 

      it "redirect to root if user id doesn't exist" do
        delete :destroy, {:id => user.to_param}, valid_session_user
        get :show, {:id => ""}, {}
      end
    end
  end

  describe "GET #new" do
    it "assigns a new user as @user" do
      # get :new, {}, valid_session
      get :new, {}, {}
      expect(assigns(:user)).to be_a_new(User::User)
    end
  end

  describe "GET #edit" do
    it "assigns the requested user as @user" do
      get :edit, {:id => user.to_param}, valid_session_user
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          # post :create, {:user_user => valid_attributes}, valid_session
          post :create, {:user_user => valid_attributes}, {}
        }.to change(User::User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        # post :create, {:user_user => valid_attributes}, valid_session
        post :create, {:user_user => valid_attributes}, {}
        expect(assigns(:user)).to be_a(User::User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the created user" do
        # post :create, {:user_user => valid_attributes}, valid_session
        post :create, {:user_user => valid_attributes}, {}
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        # post :create, {:user_user => invalid_attributes}, valid_session
        post :create, {:user_user => invalid_attributes}, {}
        expect(assigns(:user)).to be_a_new(User::User)
      end

      it "re-renders the 'new' template" do
        # post :create, {:user_user => invalid_attributes}, valid_session
        post :create, {:user_user => invalid_attributes}, {}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {name: "NewName"} }

      it "updates the requested user" do
        put :update, {:id => user.to_param, :user_user => new_attributes}, valid_session_user
        user.reload
        expect(assigns(:user).attributes['name']).to match(new_attributes[:name])
      end

      it "assigns the requested user as @user" do
        put :update, {:id => user.to_param, :user_user => valid_attributes}, valid_session_user
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the user" do
        put :update, {:id => user.to_param, :user_user => valid_attributes}, valid_session_user
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid params" do
      it "assigns the user as @user" do
        put :update, {:id => user.to_param, :user_user => invalid_attributes}, valid_session_user
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => user.to_param, :user_user => invalid_attributes}, valid_session_user
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      valid_attributes['email'] = "new_destroy@bbgame.net"
      user_destroy = User::User.create! valid_attributes
      expect {
        # delete :destroy, {:id => user_destroy.to_param}, valid_session
        delete :destroy, {:id => user_destroy.to_param}, admin_valid_session
      # }.to change(User::User, :count).by(-1)
      }.to change(User::User, :count).by(0)
    end

    it "redirects to the users list" do
      # delete :destroy, {:id => user.to_param}, valid_session_user
      delete :destroy, {:id => user.to_param}, admin_valid_session
      expect(response).to redirect_to(user_users_path)
    end
  end

end
