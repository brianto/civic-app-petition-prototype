class Resident < ActiveRecord::Base
  has_many :signatures
  has_many :petitions
  has_many :reports
  
  has_one :user, :as => :role
  accepts_nested_attributes_for :user
  
  def signed?(petition)
    self.signatures.where(:petition_id => petition.id).exists?
  end
  
  def reported?(petition)
    self.reports.where(:petition_id => petition.id).exists?
  end
end
