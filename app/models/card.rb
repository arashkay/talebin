class Card < ActiveRecord::Base

  validates_presence_of :name, :summary, :description

end
