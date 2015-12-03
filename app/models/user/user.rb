#---------------------------------------------------------------------------
# MODEL User::User extend FriendlyId
# Associations: 
# => Many(Pred::Prediction)
# Attributes: 
# => Required(name, nickname, email, birth, slug)
# => ValidFormat(email)
# => Uniqueness(email)
#---------------------------------------------------------------------------
class User::User < ActiveRecord::Base
  #============================================================================
  #   S E T   U P,    A T T R I B U T E S   A N D   A S S O C I A T I O N S
  #============================================================================
  extend FriendlyId
  self.table_name = 'users'
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  has_many :predictions, class_name: "Pred::Prediction", :dependent => :destroy
  validates_presence_of :name, :nickname, :email, :birth, :slug
  validates_format_of :email, with: EMAIL_REGEXP
  validates_uniqueness_of :email
  friendly_id :nickname, use: [:slugged, :history, :finders]
  has_secure_password
  scope :confirmed, -> { where.not(confirmed_at: nil) }
  mount_uploader :picture, PictureUploader
  before_create do |user|
    user.confirmation_token = SecureRandom.urlsafe_base64
  end

  #============================================================================
  #   P U B L I C   M E T H O D S
  #============================================================================
  #----------------------------------------------------------------------------
  # Return All Users
  # Params: Nil
  # Return: Array<User::User>
  #----------------------------------------------------------------------------
  def self.scoped
    User::User.all
  end

  #----------------------------------------------------------------------------
  # If user still not confirmed, confirm user updating confirmed_at and token
  # Params: Nil
  # Return: Nil
  #----------------------------------------------------------------------------
  def confirm!
    return if confirmed?
    self.confirmed_at = Time.current
    self.confirmation_token = ''
    save!
  end

  #----------------------------------------------------------------------------
  # Return if User is confirmed 
  # Params: Nil
  # Return: Boolean
  #----------------------------------------------------------------------------
  def confirmed?
    confirmed_at.present?
  end

  #----------------------------------------------------------------------------
  # Authenticate user if email and password are corrects
  # Params: String<email>, String<password>
  # Return: User::User
  #----------------------------------------------------------------------------
  def self.authenticate(email, password)
    user = confirmed.find_by(email: email).try(:authenticate, password)
  end

  #----------------------------------------------------------------------------
  # Task to check Users not confirmed yet during 90 days and remove from DB
  # Params: Nil
  # Return: Nil
  #----------------------------------------------------------------------------
  def self.verifyConfirmedEmails
    # query = '90 days'
    query = '8 minutes'
    users = User::User.where('(LOCALTIMESTAMP - created_at) >
      interval ? AND
      confirmed_at IS NULL AND confirmation_token IS NOT NULL', query).destroy_all
  end

end
