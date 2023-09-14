class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def show; end

  def index
    @pagy, @users = pagy(User.all, items: Settings.page_10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params # Not the final implementation!
    if @user.save
      # Handle a successful save.
      @user.send_activation_email
      flash[:info] = t "mail.check_email"
      redirect_to root_url

      # log_in @user
      # flash[:success] = t ".welcome_to_the_sample_app!"
      # redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      # Handle a successful update.
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_deleted"
    else
      flash[:danger] = t "delete_fail"
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user_not_found"
    redirect_to root_url
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "please_log_in"
    redirect_to login_url
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = t "cannot_edit_account"
    redirect_to root_url
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
