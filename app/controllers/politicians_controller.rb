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
      flash[:error] = e.to_s
      render :action => :new
    end
  end
  
  def show
    require 'will_paginate/array'
    page = params[:page].nil? ? 1 : params[:page]
    @politician = current_user.role if current_user && current_user.is_politician?
    @approved = Petition.approved.paginate(:page => page, :per_page => 10)
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
