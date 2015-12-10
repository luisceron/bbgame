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
    Pred::PredCalculatePoints.calculate(pred_fixture.filled,
                                    fixture.result_team1,
                                    fixture.result_team2,
                                    pred_fixture.pred_result_team1,
                                    pred_fixture.pred_result_team2)
  end

  #----------------------------------------------------------------------------
  # Update PredFixtures of a Fixture when this one is updated
  # Params: Comp::Fixture, Comp::Fixture(new)
  # Return: 
  #----------------------------------------------------------------------------
  def self.update_pred_fixture(fixture, new_fixture)
    pred_fixtures = Pred::PredFixture.where(fixture_id: fixture.id)
    pred_fixtures.each do |pred_fixture|      
      prediction = pred_fixture.pred_round.prediction
      Pred::Prediction.subtract_prediction_ranking(new_fixture, prediction, pred_fixture)
      new_points = Pred::Prediction.update_users_ranking(fixture, prediction, pred_fixture)
      pred_fixture.update_attributes(points: new_points)
    end
  end

  #----------------------------------------------------------------------------
  # Task to check if a Fixture is out of date
  # Params: Nil
  # Return: Nil
  #----------------------------------------------------------------------------
  def self.out_of_date_fixture
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
