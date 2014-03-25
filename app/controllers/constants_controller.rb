class ConstantsController < ApplicationController
  before_filter :ensure_admin

  def edit
    
  end
  
  def update
    @constants.update constant_params

    redirect_to admin_path    
  end
  
  private
  
  def constant_params
    params.require(:constants).permit(:goal, :site_title)
  end
end
