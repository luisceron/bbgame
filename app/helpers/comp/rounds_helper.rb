#---------------------------------------------------------------------------
# HELPER Comp::RoundsHelper
#---------------------------------------------------------------------------
module Comp::RoundsHelper
  def comp_round_form_path(comp_round)
    if comp_round.new_record?
      comp_competition_rounds_path(comp_round.competition)
    else
      comp_round_path(comp_round)
    end
  end
end
