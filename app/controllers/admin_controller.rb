class AdminController < ApplicationController
  before_filter :ensure_admin
  
  def index
    
  end
end
