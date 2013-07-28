class HoroscopesController < ApplicationController
  
  def index
    render 'general/horoscope4'
  end

  def show
    @horoscope = Horoscope.first :conditions => { :uid => params[:uid] }
  end

end
