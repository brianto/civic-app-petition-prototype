class ConstantsController < ApplicationController
  before_filter :is_admin

  def edit
    
  end
  
  def update
    @constants.update constant_params

    redirect_to admin_path    
  end
  
  private
  
  def is_admin
    unless current_user && current_user.role.is_a?(Sysadmin) then
      render :status => :forbidden
    end
  end
  
  def constant_params
    params.require(:constants).permit(:goal, :site_title, :site_description)
  end
end
