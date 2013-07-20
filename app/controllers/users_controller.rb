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

  def respond
    if(params[:value].to_i==1)
      current_user.approve User.find(params[:id])
      render :json => :accept
    elsif(params[:value].to_i==-1)
      current_user.block User.find(params[:id])
      render :json => :reject
    else
      render :json => false
    end
  end

  def invite
    current_user.invite User.find(params[:id])
    render :json => true
  end

  def point
    render :json => true
  end

  def list
    @users = User.order('updated_at DESC').paginate :page => params[:page]
  end

  def actas
    sign_in User.find params[:id]
    redirect_to home_path
  end

end
