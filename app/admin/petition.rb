ActiveAdmin.register Petition do

  
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
  
  permit_params :title, :statement, :goal, :resident
  controller do
    def create
      
      title = params[:petition][:title]
      statement = params[:petition][:statement]
      goal = params[:petition][:goal]
      resident = Resident.find_by_id(params[:petition][:resident_id])
      
      @petition = Petition.new(:title => title, :statement => statement, :goal => goal, :resident => resident)
      if @petition
        @petition.save
      end
      
      redirect_to admin_petitions_url
    end
  end
  
end
