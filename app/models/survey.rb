class Survey < ActiveRecord::Base
  attr_accessible :address, :name, :main, :demo

  validates :address, :uniqueness => true

  has_many :survey_users

  def main_address
    "surveys/main_#{address}"
  end

  def demo_address
    "surveys/demo_#{address}"
  end

end
