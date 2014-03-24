class MakePetitionsResidents < ActiveRecord::Migration
  def change
    create_table :petitions do |t|
      t.text :statement
      t.references :resident
      t.timestamps
    end
    create_table :residents do |t|
      t.string :name
      t.timestamps
    end
    create_table :signatures do |t|
      t.references :resident
      t.references :petition
      t.timestamps
    end
  end
end
