#---------------------------------------------------------------------------
# MODEL User::UserSession include ActiveModel::Model
# Attributes: 
# => Required(email, password)
# => AttributesToAccess(email, password)
#---------------------------------------------------------------------------
class User::UserSession
  #============================================================================
  #   S E T   U P,    A T T R I B U T E S   A N D   A S S O C I A T I O N S
  #============================================================================
  include ActiveModel::Model
  attr_accessor :email, :password
  validates_presence_of :email, :password

  #============================================================================
  #   P U B L I C   M E T H O D S
  #============================================================================
  #----------------------------------------------------------------------------
  # Initialize User with Session, Email and Password
  # Params: Session, Hash
  # Return: Nil
  #----------------------------------------------------------------------------
  def initialize(session, attributes={})
    @session = session
    @email = attributes[:email]
    @password = attributes[:password]
  end

  #----------------------------------------------------------------------------
  # Try to authenticate User with email and password are check
  # Params: Nil
  # Return: Keep User id or Boolean(False)
  #----------------------------------------------------------------------------
  def authenticate!
    user = User::User.authenticate(@email, @password)
    if user.present?
      store(user)
    else
      errors.add(:base, :invalid_login)
      false
    end
  end

  #----------------------------------------------------------------------------
  # Return the current User in the Session
  # Params: Nil
  # Return: User::User or Destroy Session
  #----------------------------------------------------------------------------
  def current_user
    @user = User::User.find_by_id(@session[:user_id])
    if @user == nil
      self.destroy
    else
      @user
    end
  end

  #----------------------------------------------------------------------------
  # Return if Current User is Administrator
  # Params: Nil
  # Return: Boolean
  #----------------------------------------------------------------------------
  def user_admin?
    self.current_user.admin?
  end

  #----------------------------------------------------------------------------
  # Return if User is signed in
  # Params: Nil
  # Return: Boolean
  #----------------------------------------------------------------------------
  def user_signed_in?
    @session[:user_id].present?
  end

  #----------------------------------------------------------------------------
  # Destroy Session setting as nil
  # Params: Nil
  # Return: Nil
  #----------------------------------------------------------------------------
  def destroy
    @session[:user_id] = nil
  end

  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private
    #----------------------------------------------------------------------------
    # Store User in the Session
    # Params: Nil
    # Return: Nil
    #----------------------------------------------------------------------------
    def store(user)
      @session[:user_id] = user.id
    end

end
