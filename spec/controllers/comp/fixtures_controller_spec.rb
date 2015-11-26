require 'rails_helper'

RSpec.describe Comp::FixturesController, type: :controller do
  let(:fixture){create(:comp_fixture)}
  let(:valid_attributes){attributes_for(:comp_fixture)}

  let(:invalid_attributes){{
    local: '',
    new_fixture_result1: 1,
    new_fixture_result2: 1
  }}

  let(:invalid_same_team){
    attributes_for(:comp_fixture, team1_id: 1, team2_id: 1)
  }
  
  let(:valid_session) do
    authenticated_session(create(:user_user_admin))
  end

  let!(:championship_team1){
    create(:comp_championship,
      competition_id: fixture.round.competition_id,
      team_id: fixture.team1_id)
  }

  let!(:championship_team2){
    create(:comp_championship,
      competition_id: fixture.round.competition_id,
      team_id: fixture.team2_id)
  }

  describe "GET #index" do
    it "assigns all comp_fixtures as @comp_fixtures" do
      get :index, {round_id: fixture.round_id}, valid_session
      expect(assigns(:comp_fixtures)).to eq([fixture])
    end
  end

  describe "GET #show" do
    context "with valid session" do
      it "assigns the requested comp_fixture as @comp_fixture" do
        get :show, {:id => fixture.to_param}, valid_session
        expect(assigns(:comp_fixture)).to eq(fixture)
      end
    end

    context "with invalid session" do
      it "impossible to assigns the requested comp_fixture as @comp_fixture" do
        invalid_session = authenticated_session(create(:user_user))
        get :show, {:id => fixture.to_param}, invalid_session
        expect(response).to redirect_to(root_path)
      end
    end 
  end

  describe "GET #new" do
    it "assigns a new comp_fixture as @comp_fixture" do
      get :new, {round_id: fixture.round_id}, valid_session
      expect(assigns(:comp_fixture)).to be_a_new(Comp::Fixture)
    end
  end

  describe "GET #edit" do
    it "assigns the requested comp_fixture as @comp_fixture" do
      get :edit, {:id => fixture.to_param}, valid_session
      expect(assigns(:comp_fixture)).to eq(fixture)
    end
  end

  describe "POST #create" do
    let(:round){create(:comp_round)}

    context "with valid params" do
      it "creates a new Comp::Fixture" do
        expect {
          post :create, {round_id: round.id, :comp_fixture => valid_attributes}, valid_session
        }.to change(Comp::Fixture, :count).by(1)
      end

      it "assigns a newly created comp_fixture as @comp_fixture" do
        post :create, {round_id: round.id, :comp_fixture => valid_attributes}, valid_session
        expect(assigns(:comp_fixture)).to be_a(Comp::Fixture)
        expect(assigns(:comp_fixture)).to be_persisted
      end

      it "redirects to the created comp_fixture" do
        post :create, {round_id: round.id, :comp_fixture => valid_attributes}, valid_session
        expect(response).to redirect_to(round)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved comp_fixture as @comp_fixture" do
        post :create, {round_id: round.id, :comp_fixture => invalid_attributes}, valid_session
        expect(assigns(:comp_fixture)).to be_a_new(Comp::Fixture)
      end

      it "re-renders the 'new' template" do
        post :create, {round_id: round.id, :comp_fixture => invalid_attributes}, valid_session
        expect(response).to redirect_to new_comp_round_fixture_path(round)
      end

      it 'creating new fixture with same team' do
        post :create, {round_id: round.id, :comp_fixture => invalid_same_team}, valid_session
        expect(response).to redirect_to new_comp_round_fixture_path(round)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {{
        new_fixture_result1: 2,
        new_fixture_result2: 2,
        result_team1: 2,
        result_team2: 2
      }}

      let!(:prediction){create( :pred_prediction,
                                competition_id: fixture.round.competition_id)}

      it "updates fixture with pred_fixtures" do
        post :update, {id: fixture.id, :comp_fixture => new_attributes}, valid_session
      end

      it "updates the requested comp_fixture" do
        put :update, {:id => fixture.to_param, :comp_fixture => new_attributes}, valid_session
        fixture.reload
        expect(assigns(:comp_fixture).attributes['result_team1']).to match(new_attributes[:result_team1])
      end

      it "assigns the requested comp_fixture as @comp_fixture" do
        put :update, {:id => fixture.to_param, :comp_fixture => new_attributes}, valid_session
        expect(assigns(:comp_fixture)).to eq(fixture)
      end

      it "redirects to the comp_fixture" do
        put :update, {:id => fixture.to_param, :comp_fixture => new_attributes}, valid_session
        expect(response).to redirect_to(fixture.round)
      end
    end

    context "with invalid params" do
      it "assigns the comp_fixture as @comp_fixture" do
        put :update, {:id => fixture.to_param, :comp_fixture => invalid_attributes}, valid_session
        expect(assigns(:comp_fixture)).to eq(fixture)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => fixture.to_param, :comp_fixture => invalid_attributes}, valid_session
        expect(response).to redirect_to edit_comp_fixture_path
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested comp_fixture" do
      expect {
        delete :destroy, {:id => fixture.to_param}, valid_session
      }.to change(Comp::Fixture, :count).by(-1)
    end

    it "redirects to the comp_fixtures list" do
      delete :destroy, {:id => fixture.to_param}, valid_session
      expect(response).to redirect_to(comp_round_path(fixture.round))
    end
  end

  describe "Assign_Fixture #assign_fixture" do
    it "assigns the requested assign_fixture" do
      get :assign_fixture, {:fixture_id => fixture.to_param}, valid_session
      expect(assigns(:comp_fixture)).to_not be_nil
      expect(assigns(:comp_round)).to_not be_nil
    end
  end

  describe "UPDATE_Assign_Fixture #update_assign_fixture" do
    let(:team1){create(:team_team)}
    let(:team2){create(:team_team)}

    before{
      fixture.round.competition.teams << team1
      fixture.round.competition.teams << team2
    }

    context "with valid attributes" do
      it "assigns the requested teams as @teams" do
        # Team 1 Wins
        comp_fixture = {"result_team1"=>1, "result_team2"=>0}
        put :update_assign_fixture, {fixture_id: fixture.to_param,
            comp_fixture: comp_fixture}, valid_session
        expect(response).to redirect_to fixture.round

        # Team 2 Wins
        comp_fixture = {"result_team1"=>0, "result_team2"=>1}
        put :update_assign_fixture, {fixture_id: fixture.to_param,
            comp_fixture: comp_fixture}, valid_session
        expect(response).to redirect_to fixture.round

        # Drawn
        comp_fixture = {"result_team1"=>1, "result_team2"=>1}
        put :update_assign_fixture, {fixture_id: fixture.to_param,
            comp_fixture: comp_fixture}, valid_session
        expect(response).to redirect_to fixture.round
      end
    end

    context "with invalid attributes" do
      it "assigns the requested teams as @teams" do
        comp_fixture = {"result_team1"=>'', "result_team2"=>0}
        put :update_assign_fixture, {fixture_id: fixture.to_param,
            comp_fixture: comp_fixture}, valid_session
        expect(response).to redirect_to comp_fixture_assign_fixture_path(fixture)
      end
    end
  end

  describe "POST set_fixture_done" do
    context "with valid params" do
      let!(:prediction){create( :pred_prediction,
                                competition_id: fixture.round.competition_id)}

      it "setting fixture done without pred_fixtures" do
        post :set_fixture_done, {fixture_id: fixture.id}, valid_session
      end

      it "setting fixture done with pred_fixtures" do
        post :set_fixture_done, {fixture_id: fixture.id}, valid_session
      end
    end

    context "with invalid params" do
      it "can't set fixture done" do
        fixture.update_attribute(:result_team1, nil)
        post :set_fixture_done, {fixture_id: fixture.id}, valid_session
      end
    end
  end

end
