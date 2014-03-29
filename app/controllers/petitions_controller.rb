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
  
  def find
    json = Petition
    
      # find only petitions where the query string is in title or statement
      .where("LOWER(title) LIKE :query OR LOWER(statement) LIKE :query", {
        :query => "%#{params[:query].downcase}%"
      })
      
      # give back only the title, statement, and petition path
      .inject(Array.new) do |memo, petition|
        memo + [{
          :title => petition.title,
          :statement => petition.statement,
          :url => petition_path(petition)
        }]
      end
    
    render :json => json
  end
  
end
