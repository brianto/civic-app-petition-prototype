class Petition < ActiveRecord::Base
  belongs_to :resident
  has_many :signatures
  
  
  before_create :setGoal
  after_create :signByOwner
  
  def getSuporters
    list = []
    self.signatures.each do |signature|
      list << signature
    end
    list
  end
  
  private
  def setGoal
    goal = Constants.first.goal
    self.goal = goal
  end
  
  def signByOwner
    sig = Signature.new
    sig.resident = self.resident
    sig.petition = self
    sig.save 
  end
  
end
