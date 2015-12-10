class Pred::PredCalculatePoints < ActiveRecord::Base

  def self.calculate(filled, final_first_team, final_second_team,
                      pred_first_team, pred_second_team)
    @filled = filled
    @final_first_team = final_first_team
    @final_second_team = final_second_team
    @pred_first_team = pred_first_team
    @pred_second_team = pred_second_team

    new_points = 0

    if @filled # If prediction fixture was filled up
      final_result_fixture = Pred::Ranking.define_fixture_points(@final_first_team, @final_second_team)
      pred_result_fixture  = Pred::Ranking.define_fixture_points(@pred_first_team, @pred_second_team)

      # Define if User hits or not the Result
      if final_result_fixture == pred_result_fixture  # User Hits the Result
        new_points = 70

        if @final_first_team == @pred_first_team && @final_second_team == @pred_second_team
          new_points = 150
        end

        if final_result_fixture == 1 # If Team1 Wins
          new_points += self.first_team_wins
        elsif final_result_fixture == 2 # If Team2 Wins
          new_points += self.second_team_wins
        else # If Drawn
          new_points += 20
        end

      else #User doesn't Hit the Result
        if final_result_fixture == 1 # If Team1 Wins
          new_points += self.first_team_wins 
        elsif final_result_fixture == 2 # If Team2 Wins
          new_points += self.second_team_wins
        else # If Drawn
          new_points += self.drawn
        end
      end
      new_points
    else # If prediction fixture wasn't filled up
      new_points
    end
  end

  private
    def self.first_team_wins
      if @final_first_team == @pred_first_team && @final_second_team != @pred_second_team
        return 30
      elsif @final_first_team != @pred_first_team && @final_second_team == @pred_second_team
        return 25
      else
        return 0
      end
    end

    def self.second_team_wins
      if @final_first_team != @pred_first_team && @final_second_team == @pred_second_team
        return 30
      elsif @final_first_team == @pred_first_team && @final_second_team != @pred_second_team
        return 25
      else
        return 0
      end
    end

    def self.drawn
      return 0
    end
end
