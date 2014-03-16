class PetitionsController < ApplicationController
  #
  def index
    @petitions=Petition.all
  end
  
  def new
    @petition=Petition.new
  end
  
  def create
    
    title = params[:petition][:title]
    statement = params[:petition][:statement]
    @petition = Petition.create :title => title, :statement => statement
    if @petition
      # success
      @petition.save
    else
      # error handling
    end
  end
  
  def show
    @petition = Petition.find(params[:id])
  end
end
