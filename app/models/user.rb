class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable #, :omniauthable #, :confirmable
  
  attr_accessible :name, :email, :password, :password_confirmation, :gender, :goal, :birthdate

  has_attached_file :avatar, :styles => { :medium => "100x100#", :thumb => "30x30#" }, :default_url => "/assets/noavatar-:style.jpg"
  include Amistad::FriendModel
  has_many :outbox, :class_name => 'Message', :foreign_key => :sender_id, :order => 'created_at DESC'
  has_many :inbox, :class_name => 'Message', :foreign_key => :recipient_id, :order => 'created_at DESC', :group => 'sender_id', :include => :sender do
    def unread(limit=5)
      where( :read_at => nil ).limit(limit)
    end
  end

  self.per_page = 50

  serialize :today

  def avatar_thumb
    avatar(:thumb)
  end

  def avatar_medium
    avatar(:medium)
  end

  def mailboxer_email
    return nil
  end

  def self.with_identity(id, size)
    where( ['name IS NOT NULL and avatar_file_name IS NOT NULL and id <> ?', id] ).order( 'rand()' ).limit(size)
  end

  def matches(size=15)
    User.where( ["last_sign_in_at > ?", Date.today-1.months] ).with_identity id, size
  end

  def today
    if self[:today].blank? || self[:today][:date].day != Time.now.day
      new_day = {}
      card = Card.all(:order => "rand()", :limit => 1).first
      new_day[:card] = { :name => card.name, :description => card.summary }
      new_day[:date] = Time.now
      new_day[:suggestions] = matches.select(:id).map(&:id)
      update_attribute(:today, new_day)
      return new_day
    end
    self[:today]
  end

  def horoscope
    @horoscope = Horoscope.first :conditions => { :date => (Time.now.beginning_of_week-2.days).strftime("%y-%m-%d"), :sign => JalaliDate.to_jalali(birthdate).month } unless birthdate.blank? || !@horoscope.blank?
    @horoscope
  end

  def conversation_with(user_id)
    Message.conversation( id, user_id)
  end

end
