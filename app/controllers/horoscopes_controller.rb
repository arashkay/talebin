class HoroscopesController < ApplicationController
  
  before_filter :authenticate_admin!, :only => [:new, :create]

  def index
    render 'general/horoscope4'
  end

  def show
    @horoscope = Horoscope.first :conditions => { :uid => params[:uid] }
  end
  
  def new
    @horoscopes = Horoscope.order('CAST(date as DATE) DESC, sign').limit(12)
  end

  def create
    unless params[:date].blank?
      params[:horoscope].each do |k,v|
        Horoscope.create( :date => params[:date], :sign => v[:sign], :description => v[:description] ) unless v[:description].blank?
      end
    end
    redirect_to new_horoscope_path
  end

end
