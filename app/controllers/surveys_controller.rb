class SurveysController < ApplicationController

  before_filter :authenticate_user!
  before_filter :authenticate_admin!

  def index
  end

  def show
  end

  def new
    @survey = Survey.new
  end

end
