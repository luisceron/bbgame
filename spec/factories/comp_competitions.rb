FactoryGirl.define do
  factory :comp_competition, :class => 'Comp::Competition' do
    name "MyString"
	  kind "MyString"
	  place "MyString"
    number_teams 20
    teams_added false
    post false
    started false
    number_rounds 38
  end
end
