class Politician < ActiveRecord::Base
  has_one :user, :as => :role
  accepts_nested_attributes_for :user
  
  def addressed?(petition)
    false # TODO
  end
end
