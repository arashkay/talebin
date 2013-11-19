class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @inviter = User.find params[:uniq].split("l")[1] unless params[:uniq].blank?
    @horoscopes = Horoscope.where(:date => (Time.now.beginning_of_week-2.days).strftime("%y-%m-%d")) if params[:by] == 'horoscope'
    @random_users = User.with_identity(0, 8)
    super
  end

  def create
    @inviter = User.find params[:uniq].split("l")[1] unless params[:uniq].blank?
    @random_users = User.with_identity(0, 8)
    super
    unless @inviter.blank? || current_user.blank?
      @inviter.invite current_user
      current_user.approve @inviter
    end
  end

end


