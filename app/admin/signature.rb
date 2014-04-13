ActiveAdmin.register Signature do

  
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

  menu :parent => "Users"

  controller do
    def create

      petition = Petition.find_by_id(params[:signature][:petition_id])
      resident = Resident.find_by_id(params[:signature][:resident_id])

      @signature = Signature.new(:petition => petition, :resident => resident)
      if @signature
        @signature.save!
      end

      redirect_to admin_signatures_url
    end
  end

end
