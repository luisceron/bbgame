#---------------------------------------------------------------------------
# CONTROLLER ConfirmationsController
#---------------------------------------------------------------------------
class ConfirmationsController < ApplicationController
  def show
    user = User::User.find_by(confirmation_token: params[:token])
    if user.present?
      user.confirm!
      redirect_to new_user_user_sessions_path,
          notice: I18n.t('confirmation.success')
    else
      redirect_to root_path
    end
  end
end
