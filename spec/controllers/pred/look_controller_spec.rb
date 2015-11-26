require 'rails_helper'

RSpec.describe Pred::LookController, type: :controller do
  let(:prediction){create(:pred_prediction)}

  let(:valid_session) do
    authenticated_session(prediction.user)
  end

  describe "GET #look_fixtures" do
    it "look fixtures from a User" do
      get :look_fixtures, {prediction_id: prediction.id}, valid_session
    end
  end
end
