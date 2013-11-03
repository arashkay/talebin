class SurveyUser < ActiveRecord::Base
  attr_accessible :demo, :main, :rate, :survey_id, :user_id

  belongs_to :survey

  def self.performance
    SurveyUser.select('survey_id, count(survey_id) as cnt, name').joins(:survey).group(:survey_id)
  end

end
