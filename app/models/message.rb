class Message < ActiveRecord::Base

  attr_accessible :sender, :recipient, :body, :title

  validates :sender_id, :presence => true
  validates :recipient_id, :presence => true
  validates :body, :presence => true

  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'

  self.per_page = 50

  def self.conversation( first_user_id, second_user_id )
    Message.where( [ "(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)", first_user_id, second_user_id, second_user_id, first_user_id ] ).order('created_at DESC').limit(15).includes(:sender)
  end

end
