class Pred::Ranking < ActiveRecord::Base
  def self.define_fixture_points(first_team_result, second_team_result)
    # Define flag to Fixture points
    # => Team1 Winner   -> 1
    # => Team2 Winner   -> 2
    # => Drawn      	->  3
    if first_team_result > second_team_result
      result = 1
    elsif first_team_result < second_team_result
      result = 2
    else
      result = 3
    end

  end
end
