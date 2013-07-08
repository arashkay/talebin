class UsersController < ApplicationController

  def home
    @suggestions = current_user.matches(9)
  end

  def suggest
    render :json => current_user.matches(9) , :methods => [:avatar_medium]
  end

end
