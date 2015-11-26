FactoryGirl.define do
  factory :comp_round, :class => 'Comp::Round' do
  	association :competition, factory: :comp_competition
    number_round 1
    done false
  end
end
