class AddResidentIntro < ActiveRecord::Migration
  def change
    add_column :constants, :resident_intro, :text
  end
end
