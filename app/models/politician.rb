class Politician < ActiveRecord::Base
  has_many :responses
  
  has_one :user, :as => :role
  accepts_nested_attributes_for :user
  
  def addressed?(petition)
    self.responses.where(:petition => petition).exists?
  end
  
  def response_for(petition)
    self.responses.find_by :petition => petition
  end
end
