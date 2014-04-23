class ResidentsController < ApplicationController
  def new
    @user = User.new
    @resident = Resident.new :user => @user
  end
  
  def show
    if @current_user.nil? then 
      redirect_to login_path
    end
    
    @user = Resident.find(params[:id])
  end
  
  def create
    @resident = Resident.new resident_params
    
    begin
      @resident.save!
      @resident.user.save!
      
      redirect_to resident_path @resident
    rescue Exception => e
      flash[:error] = e.to_s
      render :action => :new
    end
  end
  
  private
  
  def resident_params
    params.require(:resident).permit(:name, :user_attributes => [:email, :password, :password_confirmation])
  end
end
