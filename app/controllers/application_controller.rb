class ApplicationController < ActionController::Base
  protect_from_forgery

protected
  
  def after_sign_in_path_for(resource)
    home_path
  end 
  
  def authenticate_admin!
    redirect_to root_path unless session[:admin]
  end
end
