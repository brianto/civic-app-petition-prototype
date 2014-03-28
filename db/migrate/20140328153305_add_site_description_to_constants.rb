class AddSiteDescriptionToConstants < ActiveRecord::Migration
  def change
    add_column :constants, :site_description, :text
  end
end
