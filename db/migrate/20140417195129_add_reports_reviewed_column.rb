class AddReportsReviewedColumn < ActiveRecord::Migration
  def change
    add_column :reports, :reviewed, :boolean, :default => false, :after => :resident_id
  end
end
