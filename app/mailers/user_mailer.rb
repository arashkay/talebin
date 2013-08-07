class UserMailer < ActionMailer::Base
  default :from => "from@example.com"

  def messages_updates(user)
    @user = user
    mail :to => @user.email, :subject => 'پیام های جدید'
  end

end
