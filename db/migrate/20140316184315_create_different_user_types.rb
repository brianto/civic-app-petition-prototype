class CreateDifferentUserTypes < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      
      t.references :role, :polymorphic => true
      
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      
      t.timestamps
    end
    
    create_table :politicians do |t|
      
      t.timestamps
    end
    
    create_table :sysadmins do |t|
      
      t.timestamps
    end
  end
end
