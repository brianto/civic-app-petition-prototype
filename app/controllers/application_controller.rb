class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Y U NO WORK?
  # filter_parameter_logging :password
  
  before_action do
    @constants = Constants.first # Is there a better way to cache this?
    @current_user = current_user
    # Build the markdown engine
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(prettify: true, hard_wrap: true),
                                        tables: true, autolink: true, quote: true, footnotes: true)
    @version = Rails.configuration.version

    # Clear the flash error, since it doesn't seem to clear on it's own
    flash[:error] = nil
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
end
