class PoliticiansController < ApplicationController
  #before_filter :ensure_admin, :only => [:new, :create] # Make into new admin limit

  def new
    @user = User.new
    @politician = Politician.new :user => @user
  end
  
  def create
    @politician = Politician.new politician_params
    
    begin
      @politician.save!
      @politician.user.save!
      
      redirect_to politician_path @politician
    rescue Exception => e
      raise e.to_s
      redirect_to new_resident_path
    end
  end
  
  def show
    @politician = current_user.role if current_user && current_user.is_politician?
    @approved = Petition.approved
  end
  
  def edit
    
  end
  
  def update
    
  end

  private
  
  def politician_params
    params.require(:politician).permit(:name, :user_attributes => [:email, :password, :password_confirmation])
  end    
end
