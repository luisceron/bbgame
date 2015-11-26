#---------------------------------------------------------------------------
# CONTROLLER Comp::FixturesController
#---------------------------------------------------------------------------
class Comp::FixturesController < ApplicationController

  #============================================================================
  #   S E T   U P    
  #============================================================================
  include Comp::FixturesHelper
  before_action :require_authentication
  before_action :admin_can_change
  before_action :set_comp_fixture, only: [:show, :edit, :update, :destroy]
  before_action :set_comp_round, only: [:index, :new, :create]
  before_action :teams_not_selected, only: [:new, :edit]
  before_action :comp_fixture_params_id, only: [:assign_fixture,
                 :update_assign_fixture, :set_fixture_done]


  #============================================================================
  #   A C T I O N S
  #============================================================================
  def index
    @comp_fixtures = @comp_round.fixtures
  end

  def show
  end

  def new
    @comp_fixture = @comp_round.fixtures.new
  end

  def edit
    if can_edit(@comp_fixture) == false
      redirect_to comp_round_path(@comp_round), alert: "You must finish Fixture and Round before editing"
    end
  end

  def create
    @comp_fixture = @comp_round.fixtures.new(comp_fixture_params)
    save_and_respond(@comp_fixture, comp_round_path(@comp_round), t('fixture.created'),
                     new_comp_round_fixture_path, t('fixture.error'))
  end

  def update
    update_fixture
    if @comp_fixture.update(comp_fixture_updated_params)
      redirect_to comp_round_path(@comp_round), notice: t('fixture.updated')
    else
      redirect_to edit_comp_fixture_path, alert: t('fixture.error')
    end
  end

  def destroy
    destroy_and_respond(@comp_fixture, comp_round_path(@comp_round), t('fixture.removed'))
  end

  def assign_fixture
    get_teams_to_fixture(@comp_fixture)
  end

  def update_assign_fixture
    redirects(get_assign_fixture, @comp_round, t('fixture.assigned'),
              comp_fixture_assign_fixture_path(@comp_fixture),
              "You can't assign this Fixture")
  end

  def set_fixture_done
    redirects(set_done, @comp_round, t('fixture.fixture_done'),
                      @comp_round, t('fixture.fixture_undone'))
  end


  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private
    def update_fixture
      new_fixture = Comp::Fixture.new(comp_fixture_updated_params)
      @comp_fixture.update_fixture(new_fixture, @comp_round)
    end

    def set_done
      @comp_fixture.set_fixture_done
    end

    def get_assign_fixture
      hash_fixture = params[:comp_fixture]
      flag = Comp::Fixture.assign_fixture(@comp_fixture, hash_fixture)
    end

    def set_comp_fixture
      @comp_fixture = Comp::Fixture.find(params[:id])
      @comp_round = @comp_fixture.round
    end

    def comp_fixture_params_id
      @comp_fixture = Comp::Fixture.find(params[:fixture_id])
      @comp_round = @comp_fixture.round
    end

    def set_comp_round
      @comp_round = Comp::Round.find(params[:round_id])
    end

    def comp_fixture_params
      params.require(:comp_fixture)
            .permit(:team1_id, :team2_id, :date, :hour, :local)
    end

    def comp_fixture_updated_params
      params.require(:comp_fixture)
            .permit(:date, :hour, :local,
                    # :result_team1,
                    # :result_team2,
                    :new_fixture_result1,
                    :new_fixture_result2)
    end

    def teams_not_selected
      @teams = Team::Team.get_teams_not_selected(@comp_round)
    end

end
