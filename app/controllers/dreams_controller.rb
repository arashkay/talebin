class DreamsController < ApplicationController
  
  before_filter :authenticate_admin!, :only => [:new, :create]
  
  def index
    @dreams = Dream.order('name DESC').all
  end

  def new
    @dreams = Dream.order('id DESC').all
    @dream = Dream.new
  end

  def create
    @dream = Dream.new params[:dream]
    @dream.save
    render :new
  end

  def edit
    @dream = Dream.find params[:id]
  end

  def show
    @dreams = Dream.where( :id => params[:dream] )
  end

end
