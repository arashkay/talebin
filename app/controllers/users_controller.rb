class UsersController < ApplicationController

  def home
    @suggestions = current_user.matches(9)
  end

  def show
    @user = User.find_by_hid params[:hid]
  end

  def suggest
    render :json => current_user.matches(9) , :methods => [:avatar_medium]
  end

end
