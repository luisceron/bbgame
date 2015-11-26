#---------------------------------------------------------------------------
# HELPER Comp::CompetitionsHelper
#---------------------------------------------------------------------------
module Comp::CompetitionsHelper
  def return_rounds(competition)
  	rounds = []
  	for i in 1..competition.number_rounds
   	  rounds << i
	end
  	rounds
  end
end
