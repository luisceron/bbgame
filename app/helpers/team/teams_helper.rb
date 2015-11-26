#---------------------------------------------------------------------------
# HELPER Team::TeamsHelper
#---------------------------------------------------------------------------
module Team::TeamsHelper
  include ApplicationHelper
  
  def display_flag_from_team(team_id, width, height, classe)
    team = Team::Team.find(team_id)
    display_flag(team, width, height, classe)
  end

  def get_team_name(team_id)
    Team::Team.find(team_id).name
  end

  def get_team_short_name(team_id)
    Team::Team.find(team_id).short_name
  end
end
