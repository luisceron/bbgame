#---------------------------------------------------------------------------
# CONTROLLER ApplicationController
#---------------------------------------------------------------------------
class ApplicationController < ActionController::Base

  #============================================================================
  #   S E T   U P    
  #============================================================================
  include ControllerResponder
  protect_from_forgery with: :exception
  before_action :user_session
  before_action :user_signed
  delegate :current_user, :user_signed_in?, :user_admin?, to: :user_session
  helper_method :current_user, :user_signed_in?, :user_admin?
  before_action do
    I18n.locale = params[:locale] || I18n.default_locale
  end

  #============================================================================
  #   P U B L I C    M E T H O D S
  #============================================================================
  def default_url_options
    {locale: I18n.locale}
  end

  def user_session
    @user_session = User::UserSession.new(session)
  end

  def user_signed
    if user_signed_in?
      @user = @user_session.current_user
    end
  end

  def require_authentication
    unless user_signed_in?
      redirect_to new_user_user_sessions_path, alert: t('notice.needs_login')
    end
  end

  def require_no_authentication
    if user_signed_in?
      redirect_to root_path, notice: t('notice.logged_in')
    end
  end

  def can_change
    unless user_signed_in? && current_user.id == @pred_prediction.user_id
      redirect_to pred_predictions_url
    end
  end

  def admin_can_change
    unless user_admin?
      redirect_to root_path
    end
  end
  
end
