class PetitionsController < ApplicationController
  #
  def index
    @petitions=Petition.all
  end
  
  def new
    if @current_user.nil? then 
      redirect_to login_path
    end
    
    @petition=Petition.new
  end
  
  def create
    
    title = params[:petition][:title]
    statement = params[:petition][:statement]
    @petition = Petition.create :title => title, :statement => statement, :goal => @constants.goal
    if @petition
      # success
      @petition.save
      redirect_to petition_url @petition
    else
      # error handling
    end
  end
  
  def show
    @petition = Petition.find(params[:id])
    @signatures = @petition.getSuporters
    @count = @signatures.length
  end
end
