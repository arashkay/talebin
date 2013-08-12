class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :authenticate_admin!, :only => :list

  def home
    current_user.force_avatar!
    @suggestions = current_user.matches(9)
    @surveys = Survey.where(['survey_users.user_id <> ? OR survey_users.user_id IS NULL',current_user.id]).joins('LEFT JOIN survey_users ON survey_users.survey_id = surveys.id').limit(3)
  end

  def show
    @user = User.find_by_hid params[:hid]
  end

  def update
    @user = current_user
    @user.name = params[:user][:name] || @user.name
    @user.goal = params[:user][:goal] || @user.goal
    @user.interests = params[:user][:interests] || @user.interests
    @user.subscribed = params[:user][:subscribed] || @user.subscribed
    @user.gender = case params[:user][:gender]
                   when 'true'
                     true
                   when 'false'
                     false
                   else
                     @user.gender
                   end
    @user.birthdate = JalaliDate.to_gregorian params[:user][:birthdate] unless params[:user][:birthdate].blank?
    @user.save
    render :json => true
  end

  def suggest
    current_user.force_avatar!
    if current_user.forced_avatar?
      render :json => nil
    else
      render :json => current_user.matches(9) , :methods => [:avatar_medium]
    end
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
    if params[:type].blank?
      @users = User.order('created_at DESC').paginate :page => params[:page]
    elsif params[:type] == 'login'
      @users = User.order('last_sign_in_at DESC').paginate :page => params[:page]
    elsif params[:type] == 'login_count'
      @users = User.order('sign_in_count DESC').paginate :page => params[:page]
    end
  end

  def actas
    sign_in User.find params[:id]
    redirect_to home_path
  end

  def avatar
    current_user.avatar = params[:avatar]
    current_user.save
    render :json => { :avatar => current_user.avatar(:medium) }
  end

end
