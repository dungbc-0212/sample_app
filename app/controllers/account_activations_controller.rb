class AccountActivationsController < ApplicationController
  before_action :load_user, only: %i(edit)

  def edit
    @user.activate
    log_in @user
    flash[:success] = t "mail.account_activated"
    redirect_to @user
  end

  private
  def load_user
    @user = User.find_by email: params[:email]
    return if @user && !@user.activated && @user.authenticated?(:activation,
                                                                params[:id])

    flash[:danger] = t "mail.invalid_activation_link"
    redirect_to root_url
  end
end
