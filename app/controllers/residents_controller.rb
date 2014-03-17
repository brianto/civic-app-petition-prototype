class ResidentsController < ApplicationController
  def new
    @user = User.new
    @resident = Resident.new :user => @user
  end
  
  def create
    @resident = Resident.new resident_params
    
    begin
      @resident.save!
      @resident.user.save!
      
      redirect_to resident_path @resident
    rescue Exception => e
      raise e.to_s
      redirect_to new_resident_path
    end
  end
  
  private
  
  def resident_params
    params.require(:resident).permit(:name, :user_attributes => [:email, :password, :password_confirmation])
  end
end
