ActiveAdmin.register User do

  
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

  permit_params :name, :email, :type, :password
  controller do
    def create
      name = params[:user][:name]
      user = Hash.new
      user[:email] = params[:user][:email]
      user[:password] = params[:user][:password]
      user[:password_confirmation] = params[:user][:password]

      # Validate type
      newUser = nil
      if(params[:user][:role_type].match(/Politician/))
        newUser = Politician.new(:name => name, :user_attributes => user)
      elsif(params[:user][:role_type].match(/Resident/))
        newUser = Resident.new(:name => name, :user_attributes => user)
      end

      if(newUser.nil?)
        raise "Wrong user type"
      else
        newUser.save!
        redirect_to admin_users_url
      end
    end
  end

  # INDEX PAGE
  filter :role_type
  filter :email
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :id
    column :email
    column :role_type
    column :created_at
    column :updated_at
    actions
  end

  # NEW / EDIT PAGE
  form do |f|
    f.inputs "User" do
      f.input :name, :label => "Name", :required => true
      f.input :role_type, :as => :select, :collection => ["Resident", "Politician"], :label => "Role Type"
      f.input :email, :as => :email, :label => "Email"
      f.input :password, :as => :password, :label => "Password"
    end
    f.actions
  end
end