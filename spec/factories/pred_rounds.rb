FactoryGirl.define do
  factory :pred_round, :class => 'Pred::PredRound' do
  	association :prediction, factory: :pred_prediction
  	association :round, factory: :comp_round
  end
end
