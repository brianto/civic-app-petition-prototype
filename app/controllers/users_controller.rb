class UsersController < ApplicationController
  
  def show
    user = User.find(params[:id])
    redirect_to user.role
  end
  
end