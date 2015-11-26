#---------------------------------------------------------------------------
# CONTROLLER Pred::LookController
#---------------------------------------------------------------------------
class Pred::LookController < ApplicationController

  #============================================================================
  #   A C T I O N S
  #============================================================================
  def look_fixtures
    show_round_predictions
  end

  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private
    def show_round_predictions
      @pred_prediction = Pred::Prediction.find(params['prediction_id'])
      @pred_rounds = @pred_prediction.pred_rounds.includes(:round)
      @pred_round = Pred::PredRound.show_round_predictions(@pred_rounds,
                      params['pred_round_id'], params['d'])
      if @pred_round.present? == false
        redirect_to pred_prediction_path(@pred_prediction), alert: "Do not have Fixtures yet"
      else
        @pred_fixtures = @pred_round.pred_fixtures
      end
    end

end
