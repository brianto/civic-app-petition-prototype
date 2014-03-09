class AddTitleToPetitions < ActiveRecord::Migration
  def change
    add_column :petitions, :title, :string
  end
end
