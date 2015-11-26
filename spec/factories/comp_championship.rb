FactoryGirl.define do
  factory :comp_championship, :class => 'Comp::Championship' do
    association :competition, factory: :comp_competition
    association :team, factory: :team_team
    position 1
    points 0
    played 0
    won 0
    drawn 0
    lost 0
    goals_for 0
    goals_against 0
    goals_difference 0
  end
end
