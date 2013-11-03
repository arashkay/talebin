class SurveysController < ApplicationController

  before_filter :authenticate_user!
  before_filter :authenticate_admin!, :only => [:index,:new,:create,:edit,:update]

  def index
    @surveys = Survey.all
  end

  def show
    @survey = Survey.find params[:id]
    return redirect_to home_path if SurveyUser.where( :survey_id => params[:id], :user_id => current_user.id ).count > 0
    @users = User.where( :survey_users => { :survey_id => params[:id] } ).joins(:survey_users).order('survey_users.created_at DESC').limit(6)
  end

  def new
    @surveys = Survey.order('created_at DESC').all
    @survey = Survey.new
  end

  def create
    @survey = Survey.new params[:survey]
    if @survey.save
      redirect_to surveys_path
    else
      @surveys = Survey.order('created_at DESC').all
      render :new
    end
  end

  def edit
    @surveys = Survey.order('created_at DESC').all
    @survey = Survey.find params[:id]
    render :new
  end

  def update
    @survey = Survey.find params[:id]
    @survey.is_live = false if params[:survey][:is_live].blank?
    if @survey.update_attributes params[:survey]
      redirect_to surveys_path
    else
      @surveys = Survey.order('created_at DESC').all
      render :new
    end
  end

end
