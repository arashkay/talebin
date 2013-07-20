class GeneralController < ApplicationController

  def index
  end

  def static
    render "#{params[:page]}#{params[:id]}"
  end

end 
