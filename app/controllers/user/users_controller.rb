#---------------------------------------------------------------------------
# CONTROLLER User::UsersController
#---------------------------------------------------------------------------
class User::UsersController < ApplicationController

  #============================================================================
  #   S E T   U P    
  #============================================================================
  before_action :require_no_authentication, only: [:new, :create]
  before_action :user_change, only: [:edit, :update, :show]
  # before_action :can_change, only: [:edit, :update, :show, :index, :destroy]
  before_action :can_change, only: [:index, :destroy]
  before_action :admin_can_change, only: [:index, :destroy]

  #============================================================================
  #   A C T I O N S
  #============================================================================
  def index
    load_users
  end

  def show
    load_user
  end

  def new
    new_user
  end

  def create
    save_user or render 'new'
  end

  def edit
    load_user
  end

  def update
    load_user
    update_user or render 'edit'
  end

  def destroy
    load_user
    @user.destroy
    redirect_to user_users_path
  end

  #============================================================================
  #   P R I V A T E   M E T H O D S
  #============================================================================
  private
    def load_users
      # @users ||= user_scope.to_a
      @users = User::User.all
    end

    def load_user
      # @user ||= user_scope.friendly.find(params[:id])
      @user = User::User.find(params[:id])
    end

    def new_user
      @user = User::User.new
    end

    def save_user
      @user = User::User.new(user_params)
      if @user.save
        # Signup.confirm_email(@user).deliver
        Signup.confirm_email(@user).deliver_now
        redirect_to root_path, notice: t('user.created') + " #{@user.email}"
      end
    end

    def update_user
      if @user.update(user_params)
        redirect_to @user, notice: t('user.updated')
      end
    end

    def user_params
      params.require(:user_user)
            .permit(:picture,
                    :name,
                    :nickname,
                    :email,
                    :birth,
                    :gender,
                    :city,
                    :phone,
                    :mobile,
                    :password,
                    :password_confirmation)
    end

    def user_scope
      User::User.scoped
    end

    def user_change
      unless user_signed_in? && (current_user == load_user || user_admin?)
      # unless user_signed_in? && user_admin?
        # redirect_to user_user_path(params[:id])
        redirect_to root_path
      end
    end

    def can_change
      # unless user_signed_in? && current_user == load_user
      #   redirect_to user_user_path(params[:id])
      # end

      # unless user_signed_in? && (current_user == load_user || user_admin?)
      unless user_signed_in? && user_admin?
        # redirect_to user_user_path(params[:id])
        redirect_to root_path
      end
    end

    def admin_can_change
      unless user_admin?
        redirect_to root_path
      end
    end

end
