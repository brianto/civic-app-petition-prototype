ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Info" do
          para "Welcome to Everyday City People"
          h2 "Admin Tasks"
          ul do
            li link_to "Manage Users", admin_users_path
            li link_to "Manage Petitions", admin_petitions_path
          end

          text_node  "For more info check the top bar or the application documentation at: "
          text_node link_to("Everyday City People", "https://github.com/brianto/civic-app-petition-prototype")
        end
      end
      column do
        petitions_reported = {}
        Report.where(:reviewed => true).map do |report|
          if(petitions_reported.has_key?(report))
            petitions_reported[:report] += 1
          else
            petitions_reported[:report] = 1
          end
        end
        if(petitions_reported.empty?)
          panel "New Reports" do
            table_for petitions_reported.keys do |petition|
              column "Petition", petition.title.to_s
              column "Number of Reports", petitions_reported[petition].to_s
            end
          end
        else
          h2 "No reports"
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
