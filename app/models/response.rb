class Response < ActiveRecord::Base
  belongs_to :petition
  belongs_to :politician
  
  validates :statement, :presence => true
end
