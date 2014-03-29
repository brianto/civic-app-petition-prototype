class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Y U NO WORK?
  # filter_parameter_logging :password
  
  before_action do
    @constants = Constants.first
    @current_user = current_user
  end
  
  helper_method :current_user

  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
    
  def ensure_admin
    unless current_user && current_user.is_sysadmin? then
      render :status => :forbidden
    end
  end
end
