class Resident < ActiveRecord::Base
  has_many :signatures
  has_many :petitions
  
  has_one :user, :as => :role
  accepts_nested_attributes_for :user
  
  def signed?(petition)
    self.signatures.where(:petition_id => petition.id).exists?
  end
end
