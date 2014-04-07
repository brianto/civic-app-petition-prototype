ActiveAdmin.register_page "Constants" do

  content do
    #@constant = Constants.first
    render :partial => "constants/edit"
  end


end
