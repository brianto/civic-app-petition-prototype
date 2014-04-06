class Signature < ActiveRecord::Base
  belongs_to :petition
  belongs_to :resident
  
  validates :resident, :uniqueness => { :scope => :petition }
  
  # Set default for pagination
  self.per_page = 1#20
end
