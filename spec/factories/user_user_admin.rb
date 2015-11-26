FactoryGirl.define do
  factory :user_user_admin, :class => 'User::User' do
    name "UserFactoryName1"
    nickname "UserFactory1"
    email "userfactoryadmin@bbgame.net"
    birth "31/10/1996"
    password "123"
    gender ""
    city ""
    phone ""
    mobile ""
    confirmed_at "10/10/2001"
    admin true
  end

end
