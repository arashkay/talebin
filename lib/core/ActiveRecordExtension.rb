module ActiveRecordExtension
  
  extend ActiveSupport::Concern

  def hid
    self.id
  end

  module ClassMethods
    def find_by_hid(id)
      find_by_id id
    end
  end

end

ActiveRecord::Base.send(:include, ActiveRecordExtension)
