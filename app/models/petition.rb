class Petition < ActiveRecord::Base
  belongs_to :resident
  has_many :signatures
  
  
  before_create :setGoal
  
  private
  def setGoal
    goal = Constants.first.goal
    self.goal = goal
  end
end
