class Petition < ActiveRecord::Base
  belongs_to :resident
  has_many :signatures
  has_many :responses
  
  before_create :setGoal
  after_create :signByOwner
  
  def self.approved
    select { |p| p.signatures.count >= p.goal }
  end
  
  def approved?
    self.signatures.count >= self.goal
  end

  private
  
  def setGoal
    goal = Constants.first.goal
    self.goal = goal
  end
  
  def signByOwner
    Signature.create \
      :resident => self.resident,
      :petition => self
  end
  
end
