#---------------------------------------------------------------------------
# CONTROLLER Team::TeamsController
#---------------------------------------------------------------------------
class Team::TeamsController < ApplicationController
  
  #============================================================================
  #   S E T   U P    
  #============================================================================
  before_action :require_authentication
  before_action :can_change
  before_action :set_team_team, only: [:show, :edit, :update, :destroy]

  #============================================================================
  #   A C T I O N S
  #============================================================================
  def index
    @team_teams = Team::Team.all
  end

  def show
  end

  def new
    @team_team = Team::Team.new
  end

  def edit
  end

  def create
    @team_team = Team::Team.new(team_team_params)

    if @team_team.save
      redirect_to team_teams_path, notice: t('team.created')
    else
      redirect_to new_team_team_path, alert: t('team.not_created')
    end
  end

  def update
    if @team_team.update(team_team_params)
      redirect_to team_teams_path, notice: t('team.updated')
    else
      redirect_to edit_team_team_path, alert: t('team.not_updated')
    end
  end

  def destroy
    flag_cant_remove = 0
    competition_name = ""
    
    competitions = Comp::Competition.all
    competitions.each do |competition|
      competition.teams.each do |comp_team|
        if comp_team.id == @team_team.id
          flag_cant_remove = 1
          competition_name = competition.name
          break
        end
      end
    end

    if flag_cant_remove == 0
      @team_team.destroy
      redirect_to team_teams_url, notice: t('team.removed')
    else
      redirect_to team_teams_path, alert: "Impossible to remove this team. "+competition_name+" has it."
    end
  end

  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private
    def set_team_team
      @team_team = Team::Team.find(params[:id])
    end

    def team_team_params
      params.require(:team_team).permit(:flag, :name, :short_name, :country)
    end

    def can_change
      unless user_admin?
        redirect_to root_path
      end
    end
end
