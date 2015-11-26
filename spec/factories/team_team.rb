FactoryGirl.define do
  factory :team_team, :class => 'Team::Team' do
    name "MyString"
	country "MyString"
	short_name "XXX"
    after :create do |b|
      b.update_column(:flag, "app/assets/images/user/user_default.jpg")
    end
  end
end
