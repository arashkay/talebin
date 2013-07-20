class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @inviter = User.find params[:uniq].split("l")[1] unless params[:uniq].blank?
    @random_users = User.with_identity(0, 8)
    super
  end

  def create
    @inviter = User.find params[:inviter] unless params[:inviter].blank?
    @random_users = User.with_identity(0, 8)
    super
    unless @inviter.blank? || current_user.blank?
      @inviter.invite current_user
      current_user.approve @inviter
    end
  end

end


