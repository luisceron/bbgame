#---------------------------------------------------------------------------
# MODEL Comp::Fixture
# Associations: 
# => Many(Team, PredFixture)
# => Belong(Round)
# Attributes: 
# => Required(data, hour, local)
# => AttributesToAccess(new_fixture_result1, new_fixture_result2)
#---------------------------------------------------------------------------
class Comp::Fixture < ActiveRecord::Base
  
  #============================================================================
  #   S E T   U P,    A T T R I B U T E S   A N D   A S S O C I A T I O N S
  #============================================================================
  self.table_name = 'fixtures'
  attr_accessor :new_fixture_result1, :new_fixture_result2
  belongs_to :round, class_name: "Comp::Round", foreign_key: "round_id"
  has_many :pred_fixtures, class_name: "Pred::PredFixture", foreign_key: "fixture_id", :dependent => :destroy
  validates_presence_of :date, :hour, :local
  before_save :verify_equality_teams

  # U S E L E S S ?
  # has_many :teams, class_name: "Team::Team"

  #============================================================================
  #   P U B L I C   M E T H O D S
  #============================================================================
  #----------------------------------------------------------------------------
  # Update a Fixture 
  # Params: Fixture(New attributes), Round and Self(Old attributes)
  # Return: Nil
  #----------------------------------------------------------------------------
  def update_fixture(new_fixture, comp_round)
    first_team_new_result = new_fixture.new_fixture_result1
    second_team_new_result = new_fixture.new_fixture_result2

    # Update Competition Ranking
    unless first_team_new_result == '' || second_team_new_result == ''
      competition = Comp::Competition.find(comp_round.competition_id)
      competition.calculate_ranking(self, :-)

      new_fixture.result_team1 = self.result_team1
      new_fixture.result_team2 = self.result_team2
      self.result_team1 = first_team_new_result
      self.result_team2 = second_team_new_result
      competition.calculate_ranking(self, :+)

      # Update Users Ranking
      Pred::PredFixture.update_pred_fixture(self, new_fixture)
    end
  end

  #----------------------------------------------------------------------------
  # Set the Fixture flag (Done) true all its PredFixtures
  # Params: Self
  # Return: Integer
  #----------------------------------------------------------------------------
  def set_fixture_done
    flag = 1
    if self.result_team1 == nil || self.result_team2 == nil
      return flag = 0
    end

    if flag == 1  && self.update_attributes(done: true)    
      self.pred_fixtures.each do |pred_fixture|
        pred_fixture.update_attributes(points: Pred::PredFixture.calculate_points(self, pred_fixture))
      end
    end
    flag
  end

  #----------------------------------------------------------------------------
  # Update Fixtures, assigning results from a Hash if it is not nil and 
  # calculate Competition Ranking
  # Params: Cml::Fixtue, Hash<Integer>
  # Return: Integer
  #----------------------------------------------------------------------------
  def self.assign_fixture(comp_fixture, hash_fixture)
    flag = 1

    if hash_fixture['result_team1'] == '' || hash_fixture['result_team2'] == ''
      flag = 0
    end

    if flag == 1 && comp_fixture.update_attributes(result_team1: 
        hash_fixture['result_team1'], result_team2: hash_fixture['result_team2'])
      comp_fixture.round.competition.calculate_ranking(comp_fixture, :+)
      flag
    else
      flag = 0
    end
  end


  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private
    #----------------------------------------------------------------------------
    # Verify if a Fixture has the same teams before save
    # Params: Nil
    # Return: Nil
    #----------------------------------------------------------------------------
    def verify_equality_teams
      if self.team1_id == self.team2_id
        false
      end
    end

end
