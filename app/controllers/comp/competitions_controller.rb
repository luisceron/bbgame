#---------------------------------------------------------------------------
# CONTROLLER Comp::CompetitionsController
#---------------------------------------------------------------------------
class Comp::CompetitionsController < ApplicationController

  #============================================================================
  #   S E T   U P    
  #============================================================================
  before_action :require_authentication
  before_action :can_change
  before_action :set_comp_competition, only: [:show, :edit, :update, :destroy]
  before_action :set_competition_teams, only: [
    :add_teams, :update_teams,:ranking, :pred_league_show,
    :set_post_competition, :set_started_competition ]

  #============================================================================
  #   A C T I O N S
  #============================================================================
  def index
    @comp_competitions = Comp::Competition.all
  end

  def show
  end

  def new
    @comp_competition = Comp::Competition.new
  end

  def edit
  end

  def create
    @comp_competition = Comp::Competition.new(comp_competition_params)
    if @comp_competition.save
      redirect_to @comp_competition, notice: t('competition.created')
    else
      render :new, alert: t('competition.not_created')
    end
  end

  def update
    if @comp_competition.update(comp_competition_params)
      redirect_to @comp_competition, notice: t('competition.updated')
    else
      redirect_to edit_comp_competition_path, alert: t('competition.not_updated')
    end
  end

  def destroy
    @comp_competition.destroy
    redirect_to comp_competitions_url, notice: t('competition.removed')
  end

  def add_teams
    if @comp_competition.teams_added
      redirect_to comp_competition_path(@comp_competition), alert: t('competition.teams_added')
    else
      @teams = Team::Team.all
    end
  end

  def update_teams
    select_teams
  end

  def ranking
    get_ranking
  end

  def set_post_competition
    set_competition 'post', t('competition.posted_success')
  end

  def set_started_competition
    set_competition 'started', t('competition.started_success')
  end


  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private

    def select_teams
      hash_competition_teams = params[:competition]
      if hash_competition_teams.present?
        teams_hash = hash_competition_teams[:teams_ids]
        teams = Team::Team.find_teams(teams_hash)
        @comp_competition.teams = teams
        @comp_competition.update_attributes(teams_added: true)
      end
      redirect_to @comp_competition
    end

    def get_ranking
      @comp_championship = Comp::Championship.where(competition_id: params[:competition_id])
    end

    def set_competition(attribute, notice)
      if @comp_competition.update_attribute(attribute.to_sym, true)
        redirect_to comp_competitions_path, notice: notice
      end 
    end

    def set_comp_competition
      @comp_competition = Comp::Competition.find(params[:id])
    end

    def set_competition_teams
      @comp_competition = Comp::Competition.find(params[:competition_id])
    end

    def comp_competition_params
      params.require(:comp_competition)
            .permit(:name, :kind, :number_teams, :place, :number_rounds)
    end

    def can_change
      unless user_admin?
        redirect_to root_path
      end
    end
end
