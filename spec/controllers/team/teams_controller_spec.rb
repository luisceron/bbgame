require 'rails_helper'

RSpec.describe Team::TeamsController, type: :controller do
  let(:competition){ create(:comp_competition)}

  let(:valid_attributes) {
    attributes_for(:team_team)
  }

  let(:invalid_attributes) { {name: ''} }

  let(:valid_session) do
    authenticated_session(create(:user_user_admin))
  end

  let(:invalid_session) do
    authenticated_session(create(:user_user))
  end

  describe "GET #index" do
    it "assigns all team_teams as @team_teams" do
      team = Team::Team.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:team_teams)).to eq([team])
    end
  end

  describe "GET #show" do
    it "assigns the requested team_team as @team_team" do
      team = Team::Team.create! valid_attributes
      get :show, {:id => team.to_param}, valid_session
      expect(assigns(:team_team)).to eq(team)
    end

    it "try it without be a admin" do
      team = Team::Team.create! valid_attributes
      get :show, {id: team.to_param}, invalid_session
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #new" do
    it "assigns a new team_team as @team_team" do
      get :new, {}, valid_session
      expect(assigns(:team_team)).to be_a_new(Team::Team)
    end
  end

  describe "GET #edit" do
    it "assigns the requested team_team as @team_team" do
      team = Team::Team.create! valid_attributes
      get :edit, {:id => team.to_param}, valid_session
      expect(assigns(:team_team)).to eq(team)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Team::Team" do
        expect {
          post :create, {:team_team => valid_attributes}, valid_session
        }.to change(Team::Team, :count).by(1)
      end

      it "assigns a newly created team_team as @team_team" do
        post :create, {:team_team => valid_attributes}, valid_session
        expect(assigns(:team_team)).to be_a(Team::Team)
        expect(assigns(:team_team)).to be_persisted
      end

      it "redirects to the created team_team" do
        post :create, {:team_team => valid_attributes}, valid_session
        expect(response).to redirect_to(team_teams_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved team_team as @team_team" do
        post :create, {:team_team => invalid_attributes}, valid_session
        expect(assigns(:team_team)).to be_a_new(Team::Team)
      end

      it "re-renders the 'new' template" do
        post :create, {:team_team => invalid_attributes}, valid_session
        expect(response).to redirect_to(new_team_team_path)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {name: 'NewName'} }

      it "updates the requested team_team" do
        team = Team::Team.create! valid_attributes
        put :update, {:id => team.to_param, :team_team => new_attributes}, valid_session
        team.reload
        expect(assigns(:team_team).attributes['name']).to match(new_attributes[:name])
      end

      it "assigns the requested team_team as @team_team" do
        team = Team::Team.create! valid_attributes
        put :update, {:id => team.to_param, :team_team => valid_attributes}, valid_session
        expect(assigns(:team_team)).to eq(team)
      end

      it "redirects to the team_team" do
        team = Team::Team.create! valid_attributes
        put :update, {:id => team.to_param, :team_team => valid_attributes}, valid_session
        expect(response).to redirect_to(team_teams_path)
      end
    end

    context "with invalid params" do
      it "assigns the team_team as @team_team" do
        team = Team::Team.create! valid_attributes
        put :update, {:id => team.to_param, :team_team => invalid_attributes}, valid_session
        expect(assigns(:team_team)).to eq(team)
      end

      it "re-renders the 'edit' template" do
        team = Team::Team.create! valid_attributes
        put :update, {:id => team.to_param, :team_team => invalid_attributes}, valid_session
        expect(response).to redirect_to(edit_team_team_path)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested team_team" do
      team = Team::Team.create! valid_attributes
      expect {
        delete :destroy, {:id => team.to_param}, valid_session
      }.to change(Team::Team, :count).by(-1)
    end

    it "redirects to the team_teams list" do
      team = Team::Team.create! valid_attributes
      delete :destroy, {:id => team.to_param}, valid_session
      expect(response).to redirect_to(team_teams_url)
    end

    it "can't remove a team playing a competition" do
      team = Team::Team.create! valid_attributes
      competition.teams << team
      delete :destroy, {:id => team.to_param}, valid_session
      expect(response).to redirect_to(team_teams_url)
    end
  end

end
