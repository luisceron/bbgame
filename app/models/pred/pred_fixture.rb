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
    pred_fixtures = Pred::PredFixture.where(out_of_date_time: false)

    pred_fixtures.includes(:fixture).each do |pred_fixture|
      if fixture.date == Date.today && fixture.hour.hour == Time.now.in_time_zone.hour
        if Time.now.in_time_zone.min >= fixture.hour.min
          pred_fixture.update_attribute(:out_ofdate_time, true)
        end
      end
    end
  end









  
  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private

end
