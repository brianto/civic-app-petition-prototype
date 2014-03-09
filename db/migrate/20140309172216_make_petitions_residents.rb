class MakePetitionsResidents < ActiveRecord::Migration
  def change
    create_table :petitions do |t|
      t.text :statement
      t.references :resident
      t.timestamp
    end
    create_table :residents do |t|
      t.string :name
      t.timestamp
    end
    create_table :signatures do |t|
      t.references :resident
      t.references :petition
      t.timestamp
    end
  end
end
