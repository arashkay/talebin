class SurveyUsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :authenticate_admin!, :only => [:index]

  def create
    return redirect_to home_path if SurveyUser.where( :survey_id => params[:id], :user_id => current_user.id ).count > 0
    reply = SurveyUser.new
    reply.survey_id = params[:survey_id]
    reply.user_id = current_user.id
    reply.rate = params[:survey][:q1].to_i+params[:survey][:q2].to_i+params[:survey][:q3].to_i
    reply.main = params[:survey][:q4]
    reply.demo = params[:survey][:q5]
    reply.save
    redirect_to home_path
  end

end
