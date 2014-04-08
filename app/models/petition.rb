class Petition < ActiveRecord::Base
  belongs_to :resident
  has_many :signatures
  has_many :responses
  has_many :reports
  
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
    #Set a default if nothing is set
    if self.goal.nil?
      goal = Constants.first.goal
      self.goal = goal
    end
  end
  
  def signByOwner
    Signature.create \
      :resident => self.resident,
      :petition => self
  end
  
end
