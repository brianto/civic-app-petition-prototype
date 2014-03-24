class Signature < ActiveRecord::Base
  belongs_to :petition
  belongs_to :resident
  
  validates :resident, :uniqueness => { :scope => :petition }
end
