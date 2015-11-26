FactoryGirl.define do
  factory :pred_prediction, :class => 'Pred::Prediction' do
    association :competition, factory: :comp_competition
    association :user, factory: :user_user
    points 0
    position 1
  end
end
