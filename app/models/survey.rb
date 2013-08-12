class Survey < ActiveRecord::Base
  attr_accessible :address, :name, :main, :demo, :is_live

  validates :address, :uniqueness => true, :presence => true
  validates :name, :presence => true

  has_many :survey_users

  def main_address
    "surveys/main_#{address}"
  end

  def demo_address
    "surveys/demo_#{address}"
  end

end
