class PetitionController < ApplicationController
  #
  def index
    @petitions=Petition.first
  end
end
