class Dream < ActiveRecord::Base

  attr_accessible :description, :name

  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true

end
