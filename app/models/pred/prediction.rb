#---------------------------------------------------------------------------
# MODEL Pred::Prediction
# Associations: 
# => Belong(Competition, User)
# => Many(PredRound)
# Attributes: 
# => Required(competition_id, user_id)
#---------------------------------------------------------------------------
class Pred::Prediction < ActiveRecord::Base
  #============================================================================
  #   S E T   U P,    A T T R I B U T E S   A N D   A S S O C I A T I O N S
  #============================================================================
  self.table_name = 'predictions'
  belongs_to :competition, class_name: "Comp::Competition", foreign_key: "competition_id"
  belongs_to :user, class_name: "User::User", foreign_key: "user_id"
  has_many :pred_rounds, class_name: "Pred::PredRound", dependent: :destroy
  validates_uniqueness_of :competition_id, :scope => :user_id
  before_create :duplicate_competition_to_predictions


  #============================================================================
  #   P U B L I C   M E T H O D S
  #============================================================================
  #----------------------------------------------------------------------------
  # Calculate Users Ranking
  # Params: Integer, Integer
  # Return: Nil
  #----------------------------------------------------------------------------
  def self.calculate_users_ranking(competition_id, round_id)
  	predictions = Pred::Prediction.where(competition_id: competition_id)

  	predictions.each do |prediction|
      pred_round = prediction.pred_rounds.detect{|index| index.round_id == round_id}
  	  pred_round.pred_fixtures.each do |pred_fixture|
        fixture = Comp::Fixture.find(pred_fixture.fixture_id)
        new_points = Pred::PredFixture.calculate_points(fixture, pred_fixture)
  	    prediction.points +=new_points
  	    prediction.save
  	  end
  	end 
  	self.update_positions(predictions)
  end

  #----------------------------------------------------------------------------
  # Subtract a PredFixture from the Ranking
  # Params: Prediction, PredFixture
  # Return: Nil
  #----------------------------------------------------------------------------
  def self.subtract_prediction_ranking(fixture, prediction, pred_fixture)
    sub_points = Pred::PredFixture.calculate_points(fixture, pred_fixture)
    prediction.points -= sub_points
    prediction.save
  end

  #----------------------------------------------------------------------------
  # Update Users Ranking and return the new points
  # Params: Prediction, PredFixture
  # Return: Integer
  #----------------------------------------------------------------------------
  def self.update_users_ranking(fixture, prediction, pred_fixture)
    new_points = Pred::PredFixture.calculate_points(fixture, pred_fixture)
    prediction.points += new_points
    prediction.save

    predictions = Pred::Prediction.where(competition_id: prediction.competition_id)
    self.update_positions(predictions)
    new_points
  end


  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private
    #----------------------------------------------------------------------------
    # Update Users Ranking
    # Params: Array<Prediction>
    # Return: Nil
    #----------------------------------------------------------------------------
    def self.update_positions(predictions)
      predictions_ordered_by_points = predictions.order(points: :desc)
      position = 1

      predictions_ordered_by_points.each do |pred|
        pred.position = position
        position += 1
        pred.save
      end
    end

    #----------------------------------------------------------------------------
    # Duplicate All Rounds and Fixture of the Competition before create Prediction
    # Params: Nil
    # Return: Nil
    #----------------------------------------------------------------------------
    def duplicate_competition_to_predictions
      @user = User::User.find(self.user_id)
      @comp_competition = Comp::Competition.find(self.competition_id)

      # ---------- C O P Y I N G     R O U N D S ----------
      comp_rounds = @comp_competition.rounds
      comp_rounds.each do |comp_round|
        pred_round = Pred::PredRound.new
        pred_round.round_id = comp_round.id
          
        if pred_round.save

          # ---------- C O P Y I N G     F I X T U R E S ----------
          comp_round.fixtures.each do |fixture|
            pred_fixture = Pred::PredFixture.new
            pred_fixture.fixture_id = fixture.id
            if pred_fixture.save
              pred_round.pred_fixtures << pred_fixture
            end
          end

          self.pred_rounds << pred_round
        end
      end
    end

end
