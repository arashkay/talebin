class UsersController < ApplicationController

  def suggest
    render :json => current_user.matches(9) , :methods => [:avatar_medium]
  end

end
