class PetitionsController < ApplicationController
  #
  def index
    @petitions=Petition.all
  end
  
  def new
    if @current_user.nil? then 
      redirect_to login_path
    end
    
    @petition = Petition.new
  end
  
  def create
    
    title = params[:petition][:title]
    statement = params[:petition][:statement]
    @petition = Petition.create :title => title, :statement => statement, :goal => @constants.goal, :resident => @current_user.role
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
    @show_sign = (not @current_user.nil? and not @current_user.role.signedPetition(@petition))
  end
  
  def sign
    petition = Petition.find(params[:id])

    Signature.create \
      :petition => petition,
      :resident => @current_user.role    
    
    redirect_to petition_url petition
  end
  
  def search
    
  end
  
  def find
    # Get the search string
    searcher = Regexp.new params[:SearchString], true # case insensitive
    
    ret = []
    
    # Search through titles
    petitions = Petition.all
    
    petitions.each do |petition|
      if searcher.match petition.title
        ret << petition
      elsif searcher.match petition.statement
        ret << petition
      end
    end
    
    @petitions = ret
    
    render :partial => "partials/search_results"
  end
  
end
