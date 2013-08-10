class SurveyUser < ActiveRecord::Base
  attr_accessible :demo, :main, :rate, :survey_id, :user_id
end
