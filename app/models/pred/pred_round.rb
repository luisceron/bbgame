#---------------------------------------------------------------------------
# MODEL Pred::PredRound
# Associations: 
# => Belong(Prediction, Round)
# => Many(PredFixture)
# Attributes: 
# => Required()
#---------------------------------------------------------------------------
class Pred::PredRound < ActiveRecord::Base
  #============================================================================
  #   S E T   U P,    A T T R I B U T E S   A N D   A S S O C I A T I O N S
  #============================================================================
  self.table_name = 'pred_rounds'
  belongs_to :prediction, class_name: "Pred::Prediction", foreign_key: "prediction_id"
  belongs_to :round, class_name: "Comp::Round", foreign_key: "round_id"
  has_many :pred_fixtures, class_name: "Pred::PredFixture", dependent: :destroy, foreign_key: "pred_round_id"
  

  #============================================================================
  #   P U B L I C   M E T H O D S
  #============================================================================
  #----------------------------------------------------------------------------
  # Return the PredFixtures and PredRound to Controller with direction 
  # Params: Array<PredRound>, Integer, String
  # Return: PredRound and Array<PredFixture>
  #----------------------------------------------------------------------------
  def self.show_round_predictions(pred_rounds, pred_round_id, direction)
    if pred_round_id.present?
      @pred_round = round_direction(pred_rounds, direction, pred_round_id)
    else
      @pred_round = show_round_first_time(pred_rounds)
    end
  end

  #----------------------------------------------------------------------------
  # Update the Round Prediction
  # Params: Hash(Params)
  # Return: Hash(Integer, Integer)
  #----------------------------------------------------------------------------
  def self.update_prediction_round(params)
    flag = 0
    hash_pred_fixture = params['pred_fixture']

    if hash_pred_fixture.present?
      hash_pred_fixture.keys.each do |id|
        pred_fixture = Pred::PredFixture.find(id.to_i)
        @pred_round_id = pred_fixture.pred_round.id

        hash_fixture = round_params(params, id)
        result_first_team = hash_fixture[:pred_result_team1]
        result_second_team = hash_fixture[:pred_result_team2]

        if result_first_team != '' && result_second_team != ''
          pred_fixture.update_attributes(round_params(params, id))
          pred_fixture.update_attributes(filled: true)
          flag = 1
        end
      end
    end
    hash_return = {flag: flag, pred_round_id: @pred_round_id}
  end


  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private
    #----------------------------------------------------------------------------
    # Set the direction of the PredRound
    # Params: Array<PredRound>, String, Integer
    # Return: PredRound
    #----------------------------------------------------------------------------
    def self.round_direction(pred_rounds, direction, last_round_id)
      last_round = Pred::PredRound.find(last_round_id)
      last_number_round = last_round.round.number_round
      if direction == "1"
        next_direction = last_number_round - 1
      elsif direction == "2"
        next_direction = last_number_round + 1
      else
        next_direction = last_number_round
      end

      @pred_round = pred_rounds.detect{|index| index.round.number_round == next_direction}
      if @pred_round == nil
        @pred_round = last_round
      else
        @pred_round
      end
    end

    #----------------------------------------------------------------------------
    # Set the direction of Assign PredRounds to the first not Done
    # Params: Array<PredRound>
    # Return: PredRound
    #----------------------------------------------------------------------------
    def self.show_round_first_time(pred_rounds)
      pred_round_done = 0 
      pred_rounds.each do |pred_round|
        unless pred_round.round.done
          @pred_round = pred_round
          break
        end
        pred_round_done += 1
      end
      if pred_round_done == pred_rounds.size
        @pred_round = pred_rounds.first
      end

      @pred_round
    end

    #----------------------------------------------------------------------------
    # Returns the prediction result of a Fixture
    # Params: Hash, Integer
    # Return: Hash
    #----------------------------------------------------------------------------
    def self.round_params(params, id)
      params.require(:pred_fixture).fetch(id).permit(:pred_result_team1, :pred_result_team2)
    end
  
end
