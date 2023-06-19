class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create]
  before_action :redirect_if_authenticated, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user.present? && @user.authenticate(params[:user][:password])
      if params[:user][:remember_me] == '1'
        cookies.permanent[:remember_token] = @user.remember_token
      else
        reset_session
        session[:user_id] = @user.id
      end
      redirect_to root_path, flash: { notice: 'Logged in successfully' }
    else
      redirect_to sessions_path, flash: { alert: 'Invalid username or password' }
    end
  end

  def destroy
    reset_session
    cookies.delete(:remember_token)
    redirect_to new_session_path, flash: { notice: 'Logged out successfully' }
  end
end
