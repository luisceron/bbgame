require 'rails_helper'

RSpec.describe Comp::RoundsController, type: :controller do
  let(:round){create(:comp_round)}
  let(:valid_attributes){attributes_for(:comp_round)}
  let(:invalid_attributes) {{ number_round: '' }}

  let(:valid_session) do
    authenticated_session(create(:user_user_admin))
  end

  describe "GET #index" do
    it "assigns all comp_rounds as @comp_rounds" do
      get :index, {competition_id: round.competition_id}, valid_session
      expect(assigns(:comp_rounds)).to eq([round])
    end
  end

  describe "GET #show" do
    context "with valid session" do
      it "assigns the requested comp_round as @comp_round" do
        get :show, {:id => round.to_param}, valid_session
        expect(assigns(:comp_round)).to eq(round)
      end
    end

    context "with invalid session" do
      it "impossible to assigns the requested comp_round as @comp_round" do
        invalid_session = authenticated_session(create(:user_user))
        get :show, {:id => round.to_param}, invalid_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #new" do
    it "assigns a new comp_round as @comp_round" do
      get :new, {competition_id: round.competition_id}, valid_session
      expect(assigns(:comp_round)).to be_a_new(Comp::Round)
    end
  end

  describe "GET #edit" do
    it "assigns the requested comp_round as @comp_round" do
      get :edit, {:id => round.to_param}, valid_session
      expect(assigns(:comp_round)).to eq(round)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:competition){create(:comp_competition)}

      it "creates a new Comp::Round" do
        expect {
          post :create, {competition_id: competition.id, :comp_round => valid_attributes}, valid_session
        }.to change(Comp::Round, :count).by(1)
      end

      it "assigns a newly created comp_round as @comp_round" do
        post :create, {competition_id: competition.id, :comp_round => valid_attributes}, valid_session
        expect(assigns(:comp_round)).to be_a(Comp::Round)
        expect(assigns(:comp_round)).to be_persisted
      end

      it "redirects to the created comp_round" do
        post :create, {competition_id: competition.id, :comp_round => valid_attributes}, valid_session
        expect(response).to redirect_to(comp_competition_rounds_url(competition))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved comp_round as @comp_round" do
        post :create, {competition_id: round.competition_id, :comp_round => invalid_attributes}, valid_session
        expect(assigns(:comp_round)).to be_a_new(Comp::Round)
      end

      it "re-renders the 'new' template" do
        post :create, {competition_id: round.competition_id, :comp_round => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {{number_round: 2}}

      it "updates the requested comp_round" do
        put :update, {:id => round.to_param, :comp_round => new_attributes}, valid_session
        round.reload
        expect(assigns(:comp_round).attributes['number_round']).to match(new_attributes[:number_round])
      end

      it "assigns the requested comp_round as @comp_round" do
        put :update, {:id => round.to_param, :comp_round => valid_attributes}, valid_session
        expect(assigns(:comp_round)).to eq(round)
      end

      it "redirects to the comp_round" do
        put :update, {:id => round.to_param, :comp_round => valid_attributes}, valid_session
        expect(response).to redirect_to(round)
      end
    end

    context "with invalid params" do
      it "assigns the comp_round as @comp_round" do
        put :update, {:id => round.to_param, :comp_round => invalid_attributes}, valid_session
        expect(assigns(:comp_round)).to eq(round)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => round.to_param, :comp_round => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:round){create(:comp_round)}
    it "destroys the requested comp_round" do
      expect {
        delete :destroy, {:id => round.to_param}, valid_session
      }.to change(Comp::Round, :count).by(-1)
    end

    it "redirects to the comp_rounds list" do
      delete :destroy, {:id => round.to_param}, valid_session
      expect(response).to redirect_to(comp_competition_rounds_url(round.competition))
    end
  end

  describe "POST set_round_done" do
    let(:competition){create(:comp_competition, number_teams: 2)}
    let(:round){create(:comp_round, competition_id: competition.id)}
    let!(:fixture){create( :comp_fixture, round_id: round.id, done: true)}
    let!(:prediction){create(:pred_prediction, competition_id: competition.id)}

    context "with valid params" do
      it "setting round done" do
        post :set_round_done, {round_id: round.id}, valid_session
      end
    end

    context "with invalid params" do
      it "can't set round done" do
        round.competition.update_attributes(number_teams: 20)
        post :set_round_done, {round_id: round.id}, valid_session
      end
    end
  end

end
