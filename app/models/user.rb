class User < ActiveRecord::Base
  belongs_to :role, :polymorphic => true
  
  acts_as_authentic do |config|
    config.login_field = :email
  end
  
  def is_sysadmin?
    self.role.is_a? Sysadmin
  end
  
  def is_politician?
    self.role.is_a? Politician
  end
  
  def is_resident?
    self.role.is_a? Resident
  end
end
