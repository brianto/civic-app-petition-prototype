class AddNameToPoliticians < ActiveRecord::Migration
  def change
    add_column :politicians, :name, :string
  end
end
