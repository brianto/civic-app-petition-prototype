class CreateConstants < ActiveRecord::Migration
  def change
    create_table :constants do |t|
      t.string :site_title
      t.integer :goal

      t.timestamps
    end
  end
end
