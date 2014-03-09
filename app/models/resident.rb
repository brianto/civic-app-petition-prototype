class Resident < ActiveRecord::Base
  has_many :signatures
  has_many :petitions
end
