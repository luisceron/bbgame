FactoryGirl.define do
  factory :pred_fixture, :class => 'Pred::PredFixture' do
  	association :pred_round, factory: :pred_round
  	association :fixture, factory: :comp_fixture
    pred_result_team1 1
    pred_result_team2 1
    out_of_date_time false
    points 1
    filled false
  end
end
