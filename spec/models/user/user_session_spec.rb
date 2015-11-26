require 'rails_helper'

RSpec.describe User::UserSession, :type => :model do

  before(:each) do
  	@user_session = User::UserSession.new(set_session,
  		 {:email => "luis@wonder.com", :password => "123"})
  end

  it "must be valid" do
    expect(@user_session).to be_valid
  end
  
  #CODE: validates_presence_of :email, :password
  it "must have email" do
  	expect(@user_session).to validate_presence_of(:email)
  end

  it "must have password" do
  	expect(@user_session).to validate_presence_of(:password)
  end

end