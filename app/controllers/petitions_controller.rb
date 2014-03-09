class PetitionsController < ApplicationController
  #
  def index
    @petitions=Petition.first
  end
  
  def new
    @petition=Petition.new
  end
end
