class ResidentsController < ApplicationController
  def new
    @user = User.new
    @resident = Resident.new :user => @user
  end
  
  def create
    @resident = Resident.new resident_params
    
    if @resident.save! && @resident.user.save!
      redirect_to petitions_path
    else
      raise "hella funny"
    end
  end
  
  private
  
  def resident_params
    params.require(:resident).permit(:name, :user_attributes => [:email, :password, :password_confirmation])
  end
end
