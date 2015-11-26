require 'rails_helper'

RSpec.describe User::User, type: :model do
  let!(:user) { create(:user_user)}

  it "must be valid" do
    expect(user).to be_valid
  end

  context "when creating a new User" do
    
    #CODE: validates_presence_of :name, :nickname, :email, :birth
    it "must have a name" do
      expect(subject).to validate_presence_of(:name)
    end

    it "must have a nickname" do
      expect(subject).to validate_presence_of(:nickname)
    end

    it "must have an email" do
      expect(subject).to validate_presence_of(:email)
    end
    
    it "must have an birth" do
      expect(subject).to validate_presence_of(:birth)
    end
    
    #CODE: validates_format_of :email, with: EMAIL_REGEXP
    it "should allow this kind of format for email" do
      should allow_value("email@address.foo").for(:email)
    end

    it "should not allow this kind of format for email" do
      should_not allow_value("foo", "foo!address.foo",
                             "foo@address").for(:email)
    end
    
    #CODE: validates_uniqueness_of :email
    it "must have an unique email" do
      expect(subject).to validate_uniqueness_of(:email)
    end
    
    #CODE: has_secure_password
    it "must have has_secure_password" do
      expect(subject).to have_secure_password
    end

    #CODE: before_create do |user|
    #CODE:   user.confirmation_token = SecureRandom.urlsafe_base64
    #CODE: end
    it "verifies that confirmation_token is called" do
      expect(subject).to receive(:confirmation_token)
      subject.save(:validate => false) 
    end

    it "verifies that confirmation_token result is not nil" do
      subject.save(:validate => false) 
      expect(subject.confirmation_token).not_to be_nil
    end

    #CODE: def confirm!
    #CODE:   return if confirmed?
    #CODE:   self.confirmed_at = Time.current
    #CODE:   self.confirmation_token = ''
    #CODE:   save!
    #CODE: end
    #CODE: def confirmed?
    #CODE:   confirmed_at.present?
    #CODE: end
    it "verify confirm user and receive confirmed_at" do
      user.save
      user.confirmed_at = "not_confirmed"
      user.confirm!
      expect(user.confirmed_at).not_to be_nil
      expect(user.confirmation_token).to be_empty
      expect(user.confirmed_at).to be_truthy
    end

    it "testing verifyConfirmedEmails" do
      User::User.verifyConfirmedEmails
    end

  end
end