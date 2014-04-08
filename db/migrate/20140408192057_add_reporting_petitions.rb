class AddReportingPetitions < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :petition
      t.references :resident
      t.timestamps
    end
  end
end
