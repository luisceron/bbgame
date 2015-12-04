#---------------------------------------------------------------------------
# MODEL Pred::PredFixture
# Associations: 
# => Belong(Comp::Fixture, Pred::Round)
#---------------------------------------------------------------------------
class Pred::PredFixture < ActiveRecord::Base
  #============================================================================
  #   S E T   U P,    A T T R I B U T E S   A N D   A S S O C I A T I O N S
  #============================================================================
  self.table_name = 'pred_fixtures'
  belongs_to :pred_round, class_name: "Pred::PredRound", foreign_key: "pred_round_id"
  belongs_to :fixture, class_name: "Comp::Fixture", foreign_key: "fixture_id"

  #============================================================================
  #   P U B L I C   M E T H O D S
  #============================================================================
  #----------------------------------------------------------------------------
  # Calculate PredFixture points
  # Params: Pred::PredFixture
  # Return: Integer
  #----------------------------------------------------------------------------
  def self.calculate_points(fixture, pred_fixture)
    new_points = 0

    first_team_final_result = fixture.result_team1
    second_team_final_result = fixture.result_team2
    first_team_pred_result = pred_fixture.pred_result_team1
    second_team_pred_result = pred_fixture.pred_result_team2

    if pred_fixture.filled == true
      final_result_fixture = Pred::Ranking.define_fixture_points(first_team_final_result, second_team_final_result)
      pred_result_fixture  = Pred::Ranking.define_fixture_points(first_team_pred_result, second_team_pred_result)

      # Define User Results
      if pred_result_fixture == final_result_fixture
        new_points = 5
        if first_team_pred_result == first_team_final_result && second_team_pred_result == second_team_final_result
          new_points = 10
        end
      end
      new_points
    else
      new_points
    end
  end

  #  NEW METHOD TO CALCULATE RESULTS
  def self.calculate_points2(fixture, pred_fixture)
    new_points = 0

    first_team_final_result = fixture.result_team1
    second_team_final_result = fixture.result_team2
    first_team_pred_result = pred_fixture.pred_result_team1
    second_team_pred_result = pred_fixture.pred_result_team2

    if pred_fixture.filled == true # If prediction fixture was filled up
      final_result_fixture = Pred::Ranking.define_fixture_points(first_team_final_result, second_team_final_result)
      pred_result_fixture  = Pred::Ranking.define_fixture_points(first_team_pred_result, second_team_pred_result)

      # Define if User hits or not the Result
      if pred_result_fixture == final_result_fixture  # User Hits the Result
        new_points = 70

        if first_team_pred_result == first_team_final_result && second_team_pred_result == second_team_final_result
          new_points = 150
        end

        if final_result_fixture == 1 # If Team1 Wins
          if first_team_pred_result == first_team_final_result && second_team_pred_result != second_team_final_result
            new_points += 30
          elsif first_team_pred_result != first_team_final_result && second_team_pred_result == second_team_final_result
            new_points += 25
          else
            new_points += 0
          end
        elsif final_result_fixture == 2 # If Team2 Wins
          if first_team_pred_result != first_team_final_result && second_team_pred_result == second_team_final_result
            new_points += 30
          elsif first_team_pred_result == first_team_final_result && second_team_pred_result != second_team_final_result
            new_points += 25
          else
            new_points += 0
          end
        else # If Drawn
          if first_team_pred_result != first_team_final_result && second_team_pred_result != second_team_final_result
            new_points += 20
          end
        end

      else #User doesn't Hit the Result

      end


      new_points
    else # If prediction fixture wasn't filled up
      new_points
    end
  end

  #----------------------------------------------------------------------------
  # Update PredFixtures of a Fixture when this one is updated
  # Params: Comp::Fixture, Comp::Fixture(new)
  # Return: 
  #----------------------------------------------------------------------------
  def self.update_pred_fixture(fixture, new_fixture)
    pred_fixtures = Pred::PredFixture.where(fixture_id: fixture.id)
    pred_fixtures.each do |pred_fixture|      
      # unless new_fixture.new_fixture_result1 == '' && new_fixture.new_fixture_result2 == ''
        prediction = pred_fixture.pred_round.prediction
        Pred::Prediction.subtract_prediction_ranking(new_fixture, prediction, pred_fixture)
        new_points = Pred::Prediction.update_users_ranking(fixture, prediction, pred_fixture)
        pred_fixture.update_attributes(points: new_points)
      # end
    end
  end

  #----------------------------------------------------------------------------
  # Task to check if a Fixture is out of date
  # Params: Nil
  # Return: Nil
  #----------------------------------------------------------------------------
  def self.out_of_date_fixture
    # pred_fixtures = Pred::PredFixture.where(out_of_date_time: false)
    # pred_fixtures.each do |pred_fixture|
    #   fixture = Comp::Fixture.find(pred_fixture.fixture_id)
    #   if fixture.date == Date.today && fixture.hour.hour == Time.now.in_time_zone.hour
    #     if Time.now.in_time_zone.min >= fixture.hour.min
    #       pred_fixture.update_attribute(:out_of_date_time, true)
    #     end
    #   end
    # end

    #   NEW FUCKING  METHOD TO CALCULATE IF FIXTURE IS OUT OF DATE
    pred_fixtures = Pred::PredFixture.where(out_of_date_time: false)
    pred_fixtures.each do |pred_fixture|
      fixture = Comp::Fixture.find(pred_fixture.fixture_id)
      new_hour = fixture.hour - 10.minutes
      if fixture.date == Date.today && new_hour.to_s(:time) <= Time.now.in_time_zone.to_s(:time)
        pred_fixture.update_attribute(:out_of_date_time, true)
      end
    end
  end
  
  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private

end
