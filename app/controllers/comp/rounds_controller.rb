#---------------------------------------------------------------------------
# CONTROLLER Comp::RoundsController
#---------------------------------------------------------------------------
class Comp::RoundsController < ApplicationController

  #============================================================================
  #   S E T   U P    
  #============================================================================
  before_action :require_authentication
  before_action :can_change
  before_action :set_comp_competition, only: [ :index, :new, :create]
  before_action :set_comp_round, only: [:show, :edit, :update, :destroy]
  before_action :set_comp_round_id, only: [:set_round_done]


  #============================================================================
  #   A C T I O N S
  #============================================================================
  def index
    @comp_rounds = @comp_competition.rounds
  end

  def show
  end

  def new
    @comp_round = @comp_competition.rounds.new
  end

  def edit
  end

  def create
    @comp_round = @comp_competition.rounds.new(comp_round_params)

    if @comp_round.save
      redirect_to comp_competition_rounds_url(@comp_competition), notice: t('round.created')
    else
      render :new
    end
  end

  def update
    if @comp_round.update(comp_round_params)
      redirect_to @comp_round, notice: t('round.updated')
    else
      render :edit
    end
  end

  def destroy
    @comp_round.destroy
    redirect_to comp_competition_rounds_url(@comp_competition), notice: t('round.removed')
  end

  def set_round_done
    if set_done == 1 && @comp_round.update_attributes(done: true)
      redirect_to @comp_round, notice: t('round.round_done')
    else
      redirect_to @comp_round, alert: t('round.round_undone')
    end
  end


  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private
    def set_done
      @comp_round.set_done
    end

    def set_comp_round
      @comp_round = Comp::Round.find(params[:id])
      @comp_competition = @comp_round.competition
      @comp_fixtures = @comp_round.fixtures
    end

    def set_comp_round_id
      @comp_round = Comp::Round.find(params[:round_id])
    end

    def set_comp_competition
      @comp_competition = Comp::Competition.find(params[:competition_id])
    end

    def comp_round_params
      params.require(:comp_round)
            .permit(:number_round)
    end

    def can_change
      unless user_admin?
        redirect_to root_path
      end
    end
end
