class Horoscope < ActiveRecord::Base

  before_create :create_uid

private

  def create_uid
    self.uid = UUIDTools::UUID.timestamp_create().to_s
  end

end
