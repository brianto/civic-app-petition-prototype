class AdminController < ApplicationController
  before_filter :is_admin
  
  def index
    
  end
  
  private
  
  def is_admin
    unless current_user && current_user.role.is_a?(Sysadmin) then
      render :status => :forbidden
    end
  end
end
