require 'rails_helper'

RSpec.describe Comp::CompetitionsController, type: :controller do
  let(:competition){create(:comp_competition)}
  let(:valid_attributes){attributes_for(:comp_competition)}
  let(:invalid_attributes){{name: ''}}
  
  let(:valid_session) do
    authenticated_session(create(:user_user_admin))
  end

  describe "GET #index" do
    it "assigns all comp_competitions as @comp_competitions" do
      get :index, {}, valid_session
      expect(assigns(:comp_competitions)).to eq([competition])
    end
  end

  describe "GET #show" do
    context "with valid session" do
      it "assigns the requested comp_competition as @comp_competition" do
        get :show, {:id => competition.to_param}, valid_session
        expect(assigns(:comp_competition)).to eq(competition)
      end
    end
    context "with invalid session" do
      it "impossible to assigns the requested comp_competition as @comp_competition" do
        invalid_session = authenticated_session(create(:user_user))
        get :show, {:id => competition.to_param}, invalid_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #new" do
    it "assigns a new comp_competition as @comp_competition" do
      get :new, {}, valid_session
      expect(assigns(:comp_competition)).to be_a_new(Comp::Competition)
    end
  end

  describe "GET #edit" do
    it "assigns the requested comp_competition as @comp_competition" do
      get :edit, {:id => competition.to_param}, valid_session
      expect(assigns(:comp_competition)).to eq(competition)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Comp::Competition" do
        expect {
          post :create, {:comp_competition => valid_attributes}, valid_session
        }.to change(Comp::Competition, :count).by(1)
      end

      it "assigns a newly created comp_competition as @comp_competition" do
        post :create, {:comp_competition => valid_attributes}, valid_session
        expect(assigns(:comp_competition)).to be_a(Comp::Competition)
        expect(assigns(:comp_competition)).to be_persisted
      end

      it "redirects to the created comp_competition" do
        post :create, {:comp_competition => valid_attributes}, valid_session
        expect(response).to redirect_to(Comp::Competition.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved comp_competition as @comp_competition" do
        post :create, {:comp_competition => invalid_attributes}, valid_session
        expect(assigns(:comp_competition)).to be_a_new(Comp::Competition)
      end

      it "re-renders the 'new' template" do
        post :create, {:comp_competition => invalid_attributes}, valid_session
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {name: 'NewName'} }

      it "updates the requested comp_competition" do
        put :update, {:id => competition.to_param, :comp_competition => new_attributes}, valid_session
        competition.reload
        expect(assigns(:comp_competition).attributes['name']).to match(new_attributes[:name])
      end

      it "assigns the requested comp_competition as @comp_competition" do
        put :update, {:id => competition.to_param, :comp_competition => valid_attributes}, valid_session
        expect(assigns(:comp_competition)).to eq(competition)
      end

      it "redirects to the comp_competition" do
        put :update, {:id => competition.to_param, :comp_competition => valid_attributes}, valid_session
        expect(response).to redirect_to(competition)
      end
    end

    context "with invalid params" do
      it "assigns the comp_competition as @comp_competition" do
        put :update, {:id => competition.to_param, :comp_competition => invalid_attributes}, valid_session
        expect(assigns(:comp_competition)).to eq(competition)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => competition.to_param, :comp_competition => invalid_attributes}, valid_session
        expect(response).to redirect_to(edit_comp_competition_path)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested comp_competition" do
      competition = Comp::Competition.create! valid_attributes
      expect {
        delete :destroy, {:id => competition.to_param}, valid_session
      }.to change(Comp::Competition, :count).by(-1)
    end

    it "redirects to the comp_competitions list" do
      delete :destroy, {:id => competition.to_param}, valid_session
      expect(response).to redirect_to(comp_competitions_url)
    end
  end

  describe "ADD_TEAMS #add_teams" do
    it "assigns the requested teams as @teams" do
      get :add_teams, {:competition_id => competition.to_param}, valid_session
      expect(assigns(:teams)).to_not be_nil
    end
  end

  describe "UPDATE_TEAMS #update_teams" do
    let(:team){create(:team_team)}

    it "assigns the requested teams as @teams" do
      competitions_hash = {"teams_ids"=>[team.id]}
      get :update_teams, {competition_id: competition.to_param,
                competition: competitions_hash}, valid_session
      expect(competition.teams.size).to eq(1)
      
      get :ranking, {competition_id: competition.to_param}, valid_session
      expect(assigns(:comp_championship).size).to eq(1)
    end
  end

  describe "RANKING #ranking" do
    it "access ranking" do
      get :ranking, {competition_id: competition.to_param}, valid_session
      expect(assigns(:comp_championship)).to_not be_nil
    end
  end

end
