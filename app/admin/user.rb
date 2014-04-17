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
    column :id, :sortable => :id do |user|
      link_to(user.id.to_s, admin_user_path(user))
    end
    column "Name", :sortable => :name do |user|
      user.role.name # Get the users name
    end
    column :email
    column :role_type
    column :created_at
    column :updated_at
    actions
  end

  # NEW / EDIT PAGE
  form do |f|
    f.inputs "User" do
      f.input :name, :label => "Name", :required => true, :input_html => {:value => user.role.nil? ? "" : user.role.name}
      f.input :role_type, :as => :select, :collection => ["Resident", "Politician"], :label => "Role Type"
      f.input :email, :as => :email, :label => "Email"
      f.input :password, :as => :password, :label => "Password"
    end
    f.actions
  end

  sidebar "User Details", only: [:show, :edit] do
    ul do
    # Resident specific side stuff
    if user.is_resident?
      li link_to("Signatures", :controller => "signatures", :action => "index", "q[resident_id_eq]" => "#{user.role.id}".html_safe)
      li link_to("Petitions", :controller => "petitions", :action => "index", "q[resident_id_eq]" => "#{user.role.id}".html_safe)
    else # Any politicians stuff goes here
      h3 "Politician"
    end
    
    
    end

  end


end
