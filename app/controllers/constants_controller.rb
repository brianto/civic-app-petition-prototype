class ConstantsController < ApplicationController

  # TODO Make sure it comes from the admin dashboard
  def update
    @constants.update constant_params
    #render :nothing => true
    redirect_to admin_constants_url 
  end
  
  private
  
  def constant_params
    params.require(:constants).permit(:goal, :site_title, :site_description, :resident_intro)
  end
end
