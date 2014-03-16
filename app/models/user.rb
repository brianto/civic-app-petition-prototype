class User < ActiveRecord::Base
  belongs_to :role, :polymorphic => true
  
  acts_as_authentic do |config|
    config.login_field = :email
  end
end
