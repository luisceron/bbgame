#---------------------------------------------------------------------------
# MODEL Comp::Championship extend Comp
# Associations: 
# => Belongs(Competition, Team)
#---------------------------------------------------------------------------
class Comp::Championship < ActiveRecord::Base
  #============================================================================
  #   S E T   U P,    A T T R I B U T E S   A N D   A S S O C I A T I O N S
  #============================================================================
  extend Comp
  self.table_name = 'championships'
  belongs_to :competition, class_name: "Comp::Competition"
  belongs_to :team, class_name: "Team::Team"

  #============================================================================
  #   P U B L I C   M E T H O D S
  #============================================================================
  #----------------------------------------------------------------------------
  # Calculate(Increment ou Decrement) Competition's Ranking for each Fixture
  # Otimization:  Create a generic button that call this method just when Admin
  #               need it, not when each Fixture is assign the results.
  # Params: Comp::Fixture, operator (+ or -)
  # Return: Nil
  #----------------------------------------------------------------------------
  def self.set_ranking(championships, fixture, operation)
    championship_first_team = championships.find_by(team_id: fixture.team1_id)
    championship_second_team = championships.find_by(team_id: fixture.team2_id)

    team1_result = fixture.result_team1
    team2_result = fixture.result_team2

    # Set played
    championship_first_team.played = calc(championship_first_team.played, 1, operation)
    championship_second_team.played = calc(championship_second_team.played, 1, operation)

    # Set points, wons, draws and loses
    if team1_result == team2_result
      championship_first_team.points = calc(championship_first_team.points, 1, operation)
      championship_first_team.drawn = calc(championship_first_team.drawn, 1, operation)
      championship_second_team.points = calc(championship_second_team.points, 1, operation)
      championship_second_team.drawn = calc(championship_second_team.drawn, 1, operation)
    elsif team1_result > team2_result
      championship_first_team.points = calc(championship_first_team.points, 3, operation)
      championship_first_team.won = calc(championship_first_team.won, 1, operation)
      championship_second_team.lost = calc(championship_second_team.lost, 1, operation)
    else
      championship_second_team.points = calc(championship_second_team.points, 3, operation)
      championship_second_team.won = calc(championship_second_team.won, 1, operation)
      championship_first_team.lost = calc(championship_first_team.lost, 1, operation)
    end

    # Set goals_for
    championship_first_team.goals_for = 
      calc(championship_first_team.goals_for, team1_result, operation)
    championship_second_team.goals_for = 
      calc(championship_second_team.goals_for, team2_result, operation)

    # Set gols_against
    championship_first_team.goals_against = 
      calc(championship_first_team.goals_against, team2_result, operation)
    championship_second_team.goals_against = 
      calc(championship_second_team.goals_against, team1_result, operation)


    # Set gols_difference
    championship_first_team.goals_difference = 
      championship_first_team.goals_for - championship_first_team.goals_against
    championship_second_team.goals_difference = 
      championship_second_team.goals_for - championship_second_team.goals_against

    championship_first_team.save
    championship_second_team.save

    self.update_positions(championships) # Update position
  end

  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private
    #----------------------------------------------------------------------------
    # Update the Championship's Ranking
    # Order the Championship by: Points, Wons, Difference of Gols and Gols for
    # Params: 0
    # Return: Nil
    #----------------------------------------------------------------------------
    def self.update_positions(championships)
      pos = 1
      champ_ordered = championships.order( points: :desc, won: :desc, 
                    goals_difference: :desc, goals_for: :desc)

      champ_ordered.each do |champ_team|
        champ_team.update_attribute('position'.to_sym, pos)
        pos += 1
      end
    end

end
