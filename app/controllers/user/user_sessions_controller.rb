#---------------------------------------------------------------------------
# CONTROLLER User::UserSessionsController
#---------------------------------------------------------------------------
class User::UserSessionsController < ApplicationController

  #============================================================================
  #   S E T   U P    
  #============================================================================
  before_action :require_no_authentication, only: [:new, :create]
  before_action :require_authentication, only: :destroy

  #============================================================================
  #   A C T I O N S
  #============================================================================
  def new
    @user_session = User::UserSession.new(session)
  end

  def create
    @user_session = User::UserSession.new(session, user_user_session_params)
    if @user_session.authenticate!
      redirect_to root_path, notice: t('notice.signed_in')
    else
      render :new
    end
  end

  def destroy
    user_session.destroy
    redirect_to root_path, notice: t('notice.signed_out')
  end

  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private
    def user_user_session_params
      params.require(:user_user_session).permit(:email, :password)
    end

end
