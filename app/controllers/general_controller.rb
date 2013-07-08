class GeneralController < ApplicationController

  def index
    @suggestions = current_user.matches(9)
  end

end 
