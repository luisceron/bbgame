#---------------------------------------------------------------------------
# HELPER User::UserSessionsHelper
#---------------------------------------------------------------------------
module User::UserSessionsHelper
  def authenticated_session(user)
  	user.confirm!
    session = {}
    user_session = User::UserSession.new(session, {email: user.email, password: user.password})
    user_session.authenticate!
    raise "Error to try authenticate" unless user_session.user_signed_in? && user_session.current_user == user
    session
  end
end
