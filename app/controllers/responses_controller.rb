class ResponsesController < ApplicationController
  def new
    @petition = Petition.find(params[:petition_id])
    @response = Response.new \
      :petition => @petition,
      :politician => current_user.role
  end
  
  def create
    @response = Response.new response_params
    @response.petition = Petition.find(params[:petition_id])
    @response.politician = current_user.role

    if @response.save
      redirect_to polymorphic_path current_user.role
    else
      flash[:error] = "Error submitting petition, check your statement"
      redirect_to  new_petition_response_path Petition.find(params[:petition_id])
    end
  end
  
  def edit
    @response = Response.find params[:id]
    @petition = @response.petition
  end
  
  def update
    @response = Response.find params[:id]
    
    begin
      @response.update response_params
      @response.save!
      
      redirect_to polymorphic_path current_user.role
    rescue
      redirect_to edit_response_path(@response)
    end
  end
  
  private
  
  def response_params
    params.require(:response).permit(:statement)
  end
end
