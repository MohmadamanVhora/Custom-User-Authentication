class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authenticate_user

  private

  def current_user
    if cookies[:remember_token]
      @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    else
      @current_user = User.find_by_id(session[:user_id])
    end
  end

  def user_signed_in?
    current_user.present?
  end

  def redirect_if_authenticated
    redirect_to root_path, flash: { notice: 'You are already logged in.' } if user_signed_in?
  end

  def authenticate_user
    redirect_to new_session_path, flash: { alert: 'You must be signed in' } unless user_signed_in?
  end
end
