class PetitionsController < ApplicationController
  def index
    count = params[:count]
    page = params[:page]
    
    if(count.nil?)
      count = 5
    end
    if(page.nil?)
      page = 1
    end
    page = page.to_i
    count = count.to_i
    @petitions = Petition.order("created_at DESC").page(page)
    @page = page
    
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
    @signatures = @petition.signatures
    @count = @signatures.length
    
    @signable = current_user && current_user.is_resident? && !current_user.role.signed?(@petition)
    @respondable = current_user && current_user.is_politician? && @petition.approved?
    @addressed = @respondable && current_user.role.addressed?(@petition)
    
    @responses = Response.where(:petition => @petition)
    @my_response = Response.find_by :politician => current_user.role, :petition => @petition if @addressed
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
      .where("LOWER(title) LIKE :query OR LOWER(statement) LIKE :query", {
        :query => "%#{params[:query].downcase}%"
      })
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
