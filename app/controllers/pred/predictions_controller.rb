#---------------------------------------------------------------------------
# CONTROLLER Pred::PredictionsController
#---------------------------------------------------------------------------
class Pred::PredictionsController < ApplicationController

  #============================================================================
  #   S E T   U P    
  #============================================================================
  before_action :require_authentication
  before_action :set_pred_prediction, only: [:show, :edit, :update, :destroy]
  before_action :set_prediction_id, only: [:pred_rounds, :update_round, :pred_ranking,
                :assign_round, :assign_fixtures]
  before_action :can_change, except: [:index, :new, :create]

  #============================================================================
  #   A C T I O N S
  #============================================================================
  def index
    @pred_predictions = Pred::Prediction.where(user_id: current_user.id).all
  end

  def show
    @predictions = Pred::Prediction.where(competition_id: @pred_prediction.competition_id)
  end

  def new
    add_competition
  end

  def create
    @pred_prediction = Pred::Prediction.new(set_user_competition)
    save_and_respond @pred_prediction, @pred_prediction, t('prediction.selected'),
                     new_pred_prediction_path, t('prediction.not_selected')
  end

  def destroy
    destroy_and_respond @pred_prediction, pred_predictions_url, t('prediction.removed')
  end

  def assign_fixtures
    show_round_predictions
  end

  def update_round
    redirects(update_prediction_round,
              pred_prediction_assign_fixtures_path(@pred_prediction,
                                pred_round_id: @pred_round_id, d: 0),
              t('prediction.saved'),
              pred_prediction_assign_fixtures_path(@pred_prediction,
                                pred_round_id: @pred_round_id, d: 0),
              nil)
  end

  def pred_ranking
    @competition = Comp::Competition.find(@pred_prediction.competition_id)
    @predictions = Pred::Prediction.where(competition_id: @pred_prediction.competition_id)
  end


  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private
    def show_round_predictions
      @pred_rounds = @pred_prediction.pred_rounds.includes(:round)
      @pred_round = Pred::PredRound.show_round_predictions(@pred_rounds,
                      params['pred_round_id'], params['d'])
      if @pred_round.present? == false
        redirect_to pred_prediction_path(@pred_prediction), alert: "Do not have Fixtures yet"
      else
        @pred_fixtures = @pred_round.pred_fixtures
      end
    end

    def update_prediction_round
      hash_return = Pred::PredRound.update_prediction_round(params)
      @pred_round_id = hash_return[:pred_round_id]
      flag = hash_return[:flag]
    end

    def add_competition
      @comp_competitions = Comp::Competition.get_competitions(current_user.id)
      @pred_prediction = Pred::Prediction.new
    end

    def set_pred_prediction
      @pred_prediction = Pred::Prediction.find(params[:id])
    end

    def set_prediction_id
      @pred_prediction = Pred::Prediction.find(params[:prediction_id])
    end

    def set_user_competition
      {
        competition_id: params['competition_id'],
        user_id: current_user.id
      }
    end

end
