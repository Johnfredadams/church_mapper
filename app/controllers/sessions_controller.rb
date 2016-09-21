require 'uri'

class SessionsController < ApplicationController
  
  before_filter :check_logged_in, only: [:sign_in_as,:destroy]
  
  
  
  def create

      if User.find_by(email: env["omniauth.auth"][:info][:email].downcase)
        user = User.from_omniauth(env["omniauth.auth"])
        user.last_sign_in_at = user.current_sign_in_at
        user.current_sign_in_at = Time.now
        user.last_sign_in_ip = user.current_sign_in_ip
        user.current_sign_in_ip =  request.remote_ip
        user.save
        redirect_path = session[:redirect_path] || root_path
        domain = session[:domain]
        reset_session
        session[:user_id] = user.id
        session[:expires_at] = Time.now + ENV['SESSION_LENGTH_IN_HOURS'].to_i.hours
        session[:redirect_path] = redirect_path
        session[:domain] = domain
        redirect_to redirect_path, notice: "Welcome, #{user.name}"
        
      else
        redirect_to root_path, notice: "Sorry, that email isn't on our system."
        
      end
  end
  
  def sign_in_as
    if params[:user_id]
      session[:user_id] = params[:user_id].to_i
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    session[:expires_at] = nil
    session[:redirect_path] = nil
    reset_session
    redirect_to root_path
  end
end


