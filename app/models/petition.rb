class Petition < ActiveRecord::Base
  belongs_to :resident
  has_many :signatures
end
