FactoryGirl.define do
  factory :comp_fixture, :class => 'Comp::Fixture' do
  	association :round, factory: :comp_round
    team1_id { FactoryGirl.create(:team_team).id }
    team2_id { FactoryGirl.create(:team_team).id }
    result_team1 2
    result_team2 2
    date "23/01/2030"
    hour "18:00"
    done false
    local "MyString"
  end
end
