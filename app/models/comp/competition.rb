#---------------------------------------------------------------------------
# MODEL Comp::Competition extend Comp
# Associations: 
# => Many(Championships, Teams, Rounds and Predictions)
# Attributes: 
# => Required(name, kind, number_teams, place, number_rounds)
#---------------------------------------------------------------------------
class Comp::Competition < ActiveRecord::Base
  #============================================================================
  #   S E T   U P,    A T T R I B U T E S   A N D   A S S O C I A T I O N S
  #============================================================================
  extend Comp
  self.table_name = 'competitions'
  has_many :championships, class_name: "Comp::Championship", :dependent => :destroy
  has_many :teams, -> { order(:name)}, class_name: "Team::Team", :through => :championships
  has_many :rounds, class_name: "Comp::Round", foreign_key: "competition_id", :dependent => :destroy
  has_many :predictions, class_name: "Pred::Prediction", :dependent => :destroy
  validates_presence_of :name, :kind, :number_teams, :place, :number_rounds

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
  def calculate_ranking(fixture, operation)
    Comp::Championship.set_ranking(self.championships, fixture, operation)
  end

  #----------------------------------------------------------------------------
  # Get Competitions to show to Current User
  # Params: Integer
  # Return: Array of Competition
  #----------------------------------------------------------------------------
  def self.get_competitions(user_id)
    @user_predictions_competitions = Array.new
    @pred_predictions = Pred::Prediction.where(user_id: user_id).all
    @pred_predictions.each do |pred_prediction|
      comp_competition = Comp::Competition.find(pred_prediction.competition_id)
      @user_predictions_competitions << comp_competition
    end

    @comp_leagues = Comp::Competition.where("kind = ? AND post = ? AND started = ?", "Liga", true, false)
    @comp_competitions = @comp_leagues - @user_predictions_competitions # Initially Only Leagues
  end

  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private

end
