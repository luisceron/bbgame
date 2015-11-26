#---------------------------------------------------------------------------
# MODEL Comp::Round
# Associations: 
# => Belong(Competition)
# => Many(Fixture, PredRound)
# Attributes: 
# => Required(number_round)
#---------------------------------------------------------------------------
class Comp::Round < ActiveRecord::Base

  #============================================================================
  #   S E T   U P,    A T T R I B U T E S   A N D   A S S O C I A T I O N S
  #============================================================================
  self.table_name = 'rounds'
  belongs_to :competition, class_name: "Comp::Competition", foreign_key: "competition_id"
  has_many :fixtures, class_name: "Comp::Fixture", foreign_key: "round_id", :dependent => :destroy
  has_many :pred_rounds, class_name: "Pred::PredRound", foreign_key: "round_id", :dependent => :destroy
  validates_presence_of :number_round
  validates_uniqueness_of :number_round, :scope => :competition_id


  #============================================================================
  #   P U B L I C   M E T H O D S
  #============================================================================
  #----------------------------------------------------------------------------
  # Set Round Done True
  # Params: Self
  # Return: Integer(1 => Valid, 0 => Invalid)
  #----------------------------------------------------------------------------
  def set_done
  	flag_cannot_set_true = 1
    # Check if all fixtures was assigned
    if((self.competition.number_teams/2) == self.fixtures.size)
      self.fixtures.each do |fixture|
        if fixture.result_team1 == nil || fixture.result_team2 == nil || fixture.done == false
      	  flag_cannot_set_true = 0
      	end
      end
    else
      flag_cannot_set_true = 0
    end

    if flag_cannot_set_true == 1
      Pred::Prediction.calculate_users_ranking(self.competition.id, self.id)
    end
    flag_cannot_set_true
  end

  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private

end
