class CardsController < ApplicationController

  before_filter :pick_cards, :only => [:show, :reshow]

private
  
  def pick_cards
    if params[:cards]
      ids = params[:cards].split('i').collect { |i| i.hex }
      @list = Card.all :conditions => { :id => ids }
      @cards = []
      ids.each do |i|
        @list.each do |c|
          @cards << c if c.id.to_i == i.to_i
        end
      end
    else
      @cards = Card.all :order => "rand()", :limit => 3
    end
    @furtune = ''
    @cardsno = ''
    @cards.each { |c| @furtune = "#{@furtune} #{c.description}" }
    @cards.each { |c| @cardsno = "#{@cardsno}#{c.id.to_s(16)}i" }
  end

end
