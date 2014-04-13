ActiveAdmin.register Report do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  menu :parent => "Petitions"

  controller do
    def create

      petition = Petition.find_by_id(params[:report][:petition_id])
      politician = Resident.find_by_id(params[:response][:resident_id])
      statement = params[:response][:statement]

      @response = Response.new(:petition => petition, :politician => politician, :statement => statement)
      if @response
        @response.save!
      end

      redirect_to admin_responses_url
    end
  end
  
end
