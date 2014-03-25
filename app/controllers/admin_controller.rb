class AdminController < ApplicationController
  before_filter :is_admin
  
  def index
    
  end
  
  def configure
    
  end
  
  def update
    
  end
  
  private
  
  def is_admin
    unless current_user && current_user.role.is_a?(Sysadmin) then
      render :status => :forbidden
    end
  end
  
  def update_params
    params.require(:constants).permit(:goal, :site_title)
  end
end
