class TarotsController < ApplicationController

  before_filter :pick_cards, :only => [:show, :reshow]

private
  
  def pick_cards
    if params[:cards]
      parts = params[:cards].split('-')
      ids = parts[0].split('i').collect { |i| i.hex }
      @positivity = parts[1].split('o')
      @list = Tarot.all :conditions => { :id => ids }
      @cards = []
      ids.each do |i|
        @list.each do |c|
          @cards << c if c.id.to_i == i.to_i
        end
      end
    else
      @cards = Tarot.all :order => "rand()", :limit => 5
      @positivity = ['1','1','1','1','1','0','0','0','0'].sort_by{rand}[0..4]
    end
    @furtune = []
    @cardsno = ''
    @cards.each_index { |i| @furtune << (@positivity[i]=='1' ? @cards[i].positive : @cards[i].negative) }
    @cards.each { |c| @cardsno = "#{@cardsno}#{c.id.to_s(16)}i" }
    @cardsno = "#{@cardsno}-#{@positivity.join('o')}"
  end

end
