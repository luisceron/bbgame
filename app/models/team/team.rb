#---------------------------------------------------------------------------
# MODEL Team::Team
# Associations: 
# => Many(Championships, Competitions, Fixtures)
# Attributes: 
# => Required(name, short_name => size: 3, country)
# => Not Required(flag)
#---------------------------------------------------------------------------
class Team::Team < ActiveRecord::Base

  #============================================================================
  #   S E T   U P,    A T T R I B U T E S   A N D   A S S O C I A T I O N S
  #============================================================================
  self.table_name = 'teams'
  has_many :championships, class_name: "Comp::Championship", :dependent => :destroy
  has_many :competitions, class_name: "Comp::Competition", :through => :championships
  has_many :fixtures, class_name: "Comp::Fixture"
  validates_presence_of :name, :short_name, :country
  validates_length_of :short_name, maximum: 3
  mount_uploader :flag, FlagUploader

  #============================================================================
  #   P U B L I C   M E T H O D S
  #============================================================================
  #----------------------------------------------------------------------------
  # Find and Return the Teams selected by Admin
  # Params: Hash of Teams IDs
  # Return: Array of Team::Team
  #----------------------------------------------------------------------------
  def self.find_teams(teams_hash)
    teams = []
    teams_hash.each do |team_id|
      teams << Team::Team.find(team_id)
    end
    teams
  end

  #----------------------------------------------------------------------------
  # Return the Teams aren't selected yet to the Round
  # Params: Comp::Round
  # Return: Array<Team::Team>
  #----------------------------------------------------------------------------
  def self.get_teams_not_selected(comp_round)
    teams_selected = []
    comp_round.fixtures.each do |fixture|
      teams_selected << Team::Team.find(fixture.team1_id)
      teams_selected << Team::Team.find(fixture.team2_id)
    end
    @teams = comp_round.competition.teams - teams_selected
  end

end
