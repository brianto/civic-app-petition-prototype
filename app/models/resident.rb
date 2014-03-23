class Resident < ActiveRecord::Base
  has_many :signatures
  has_many :petitions
  
  has_one :user, :as => :role
  accepts_nested_attributes_for :user
  
  def signedPetition(petition)
    
    
    self.signatures.each do |signature|
      p = signature.petition
      if petition.id == p.id
        return true
      end 
    end
    false
  end
end
