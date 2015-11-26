require 'rails_helper'

RSpec.describe Pred::PredictionsController, type: :controller do
  let(:user){create(:user_user)}
  let(:user2){create(:user_user, email: 'anotheruser@gmail.com')}
  let(:team1){create(:team_team)}
  let(:team2){create(:team_team)}
  let(:competition){create(:comp_competition, post: true)}
  let(:prediction_another_user){create(:pred_prediction, user_id: user2.id,
    competition_id: competition.id)}

  let(:valid_attributes) {
    attributes_for(:pred_prediction).merge({
      competition_id: competition.id,
      user_id: user.id
    })
  }

  let(:invalid_attributes) { {competition_id: competition.id, user_id: user.id} }

  let(:valid_session) do
    authenticated_session(user)
  end

  describe "GET #index" do
    it "assigns all pred_predictions as @pred_predictions" do
      prediction = Pred::Prediction.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:pred_predictions)).to eq([prediction])
    end
  end

  describe "GET #show" do
    it "assigns the requested pred_prediction as @pred_prediction" do
      prediction = Pred::Prediction.create! valid_attributes
      get :show, {:id => prediction.to_param}, valid_session
      expect(assigns(:pred_prediction)).to eq(prediction)
    end
  end

  describe "GET #new" do
    let!(:prediction){create(:pred_prediction, user_id: user.id, competition_id: competition.id)}
    
    it "assigns a new pred_prediction as @pred_prediction" do
      get :new, {}, valid_session
      expect(assigns(:pred_prediction)).to be_a_new(Pred::Prediction)
    end
  end

  describe "GET #edit" do
    it "assigns the requested pred_prediction as @pred_prediction" do
      prediction = Pred::Prediction.create! valid_attributes
      get :edit, {:id => prediction.to_param}, valid_session
      expect(assigns(:pred_prediction)).to eq(prediction)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Pred::Prediction" do
        expect {
          post :create, {competition_id: competition.id, :pred_prediction => valid_attributes}, valid_session
        }.to change(Pred::Prediction, :count).by(1)
      end

      it "assigns a newly created pred_prediction as @pred_prediction" do
        post :create, {competition_id: competition.id, :pred_prediction => valid_attributes}, valid_session
        expect(assigns(:pred_prediction)).to be_a(Pred::Prediction)
        expect(assigns(:pred_prediction)).to be_persisted
      end

      it "redirects to the created pred_prediction" do
        post :create, {competition_id: competition.id, :pred_prediction => valid_attributes}, valid_session
        expect(response).to redirect_to(Pred::Prediction.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved pred_prediction as @pred_prediction" do
        prediction = Pred::Prediction.create! valid_attributes
        post :create, {competition_id: prediction.competition_id, :pred_prediction => invalid_attributes}, valid_session
        expect(assigns(:pred_prediction)).to be_a_new(Pred::Prediction)
      end

      it "re-renders the 'new' template" do
        prediction = Pred::Prediction.create! valid_attributes
        post :create, {competition_id: prediction.competition_id, :pred_prediction => invalid_attributes}, valid_session
        expect(response).to redirect_to new_pred_prediction_path
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested pred_prediction" do
      prediction = Pred::Prediction.create! valid_attributes
      expect {
        delete :destroy, {:id => prediction.to_param}, valid_session
      }.to change(Pred::Prediction, :count).by(-1)
    end

    it "redirects to the pred_predictions list" do
      prediction = Pred::Prediction.create! valid_attributes
      delete :destroy, {:id => prediction.to_param}, valid_session
      expect(response).to redirect_to(pred_predictions_url)
    end
  end

  describe "UPDATE #update_round" do
    let!(:round){create(:comp_round, competition_id: competition.id)}
    let!(:fixture){create(:comp_fixture, round_id: round.id,
                           team1_id: team1.id, team2_id: team2.id)}

    before{
      @prediction = Pred::Prediction.create! valid_attributes
      pred_round = @prediction.pred_rounds.first
      @pred_fixture = pred_round.pred_fixtures.first
    }

    it "updating fields_for" do 
      pred_fixture_hash = {@pred_fixture.id.to_s => {"pred_result_team1"=>"4", "pred_result_team2"=>"1"}}
      put :update_round, {prediction_id: @prediction.id, pred_fixture: pred_fixture_hash}, valid_session
      expect(response).to redirect_to pred_prediction_assign_fixtures_path(@prediction,
                                          pred_round_id: @pred_fixture.pred_round.id, d: 0)
    end

    it "not updating fields_for" do 
      pred_fixture_hash = {@pred_fixture.id.to_s => {"pred_result_team1"=>"4", "pred_result_team2"=>""}}
      put :update_round, {prediction_id: @prediction.id, pred_fixture: pred_fixture_hash}, valid_session
      expect(response).to redirect_to pred_prediction_assign_fixtures_path(@prediction,
                                          pred_round_id: @pred_fixture.pred_round.id, d: 0)
    end
  end

  describe 'user prediction and current user are not the same' do
    it "another user trying to access a user predicitions" do
      get :show, {:id => prediction_another_user.to_param}, valid_session
      expect(response).to redirect_to pred_predictions_url
    end
  end

end
