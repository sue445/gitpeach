class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :not_logged_in?

  private

  # if not logged in, redirect to top
  def authenticate_user
    redirect_to root_path(back_to: request.original_fullpath) if not_logged_in?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def not_logged_in?
    !logged_in?
  end

end
