FactoryGirl.define do
  factory :user_user, :class => 'User::User' do
    name "UserFactoryName1"
    nickname "UserFactory1"
    email "userfactory1@bbgame.net"
    birth "31/10/1996"
    password "123"
    gender ""
    city ""
    phone ""
    mobile ""
    confirmed_at "10/10/2001"
  end

end
