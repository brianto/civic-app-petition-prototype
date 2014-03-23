class Petition < ActiveRecord::Base
  belongs_to :resident
  has_many :signatures
  
  
  before_create :setGoal
  
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
end
