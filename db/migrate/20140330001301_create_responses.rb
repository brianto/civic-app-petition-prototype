class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :petition, index: true
      t.references :politician, index: true
      t.text :statement

      t.timestamps
    end
  end
end
