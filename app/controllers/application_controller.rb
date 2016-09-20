class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  
  def check_logged_in
    unless (session[:user_id] && session[:expires_at] && Time.now < session[:expires_at])
      session[:redirect_path] = request.original_fullpath
      session[:user_id] = nil
      session[:expires_at] = nil
      redirect_to root_path, notice: "you must be logged in."
    end
  end
end
