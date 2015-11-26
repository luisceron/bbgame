#---------------------------------------------------------------------------
# HELPER Comp::FixturesHelper
#---------------------------------------------------------------------------
module Comp::FixturesHelper
  def comp_fixture_form_path(comp_fixture)
    if comp_fixture.new_record?
      comp_round_fixtures_path(comp_fixture.round)
    else
      comp_fixture_path(comp_fixture)
    end
  end

  def can_edit(comp_fixture)
    get_teams_to_fixture(comp_fixture)
    if comp_fixture.result_team1.present? && comp_fixture.result_team2.present?
      if comp_fixture.done == false || comp_fixture.round.done == false
        return false
      end
    end
  end

  def get_teams_to_fixture(comp_fixture)
    @first_team = Team::Team.find(comp_fixture.team1_id)
    @second_team = Team::Team.find(comp_fixture.team2_id)
  end
end
