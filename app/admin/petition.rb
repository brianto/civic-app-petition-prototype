require 'redcarpet/render_strip'

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

  markdown = Redcarpet::Markdown.new \
    Redcarpet::Render::HTML.new(prettify: true, hard_wrap: true),
    tables: true,
    autolink: true,
    quote: true,
    footnotes: true
    
  plaintext = Redcarpet::Markdown.new Redcarpet::Render::StripDown.new
  
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
  
  index do
    selectable_column
    column :id, :sortable => :id do |petition|
      link_to(petition.id.to_s, admin_petition_path(petition))
    end
    column :title
    column :statement do |petition|
      raw plaintext.render petition.statement
    end
    column :resident, :sortable => 'resident_id'
    column :goal
    column :created_at
    column :updated_at
    actions
  end
  
  show do |petition|
    attributes_table do
      row :id
      row :title
      row :statement do
        raw markdown.render petition.statement
      end
      row :resident do
        link_to(petition.resident.name, admin_user_url(petition.resident.user))
      end
      row "Signatures" do
        link_to(petition.signatures.count.to_s, :controller => "signatures", 
                :action => "index", "q[petition_id_eq]" => "#{petition.id}".html_safe)
      end
      row :goal
      row "Percent Complete" do
        [(petition.signatures.count * 100.0 / petition.goal), 100].min.to_s << "%"
      end
    end
    active_admin_comments
  end
  
  filter :resident
  filter :title
  filter :statement
  filter :goal
  filter :created_at
  filter :updated_at
  
end
