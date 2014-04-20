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


      @report = Report.new(permit_params)
      if @report
        @report.save!
      end

      redirect_to admin_reports_url
    end

    def update

      @report = Report.find_by_id(params[:id])

      @report.update(permit_params)
      @report.save!

      redirect_to  admin_report_path @report
    end

    private

    def permit_params
      params.require(:report).permit(:petition_id, :resident_id, :reviewed)
    end
  end

  member_action :review, :method => :put do
    report = Report.find_by_id(params[:id])

    report.reviewed = true
    report.save!

    redirect_to  admin_report_path report
  end

  sidebar :report_actions, :only => :show do
    report = Report.find_by_id(params[:id])
    ul do
      li link_to "Mark as Reviewed",  review_admin_report_path(report), :method => :put
      li link_to "Remove Petition",  admin_petition_path(report.petition), :method => :delete
    end
  end
  
end
