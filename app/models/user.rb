class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable #, :omniauthable #, :confirmable
  has_attached_file :avatar, :styles => { :medium => "120x120#", :thumb => "50x50#" }, :default_url => "/images/avatar.jpg"
  include Amistad::FriendModel
  #acts_as_network :friends, :through => :invites, :conditions => "is_accepted = true"
  
  serialize :today

  def avatar_medium
    avatar(:medium)
  end

  def self.with_identity(id, size)
    where( ['name IS NOT NULL and avatar_file_name IS NOT NULL and id <> ?', id] ).order( 'rand()' ).limit(size)
  end

  def matches(size)
    User.with_identity id, size
  end

  def today
    if self[:today].blank? || self[:today][:date].day != Time.now.day
      new_day = {}
      card = Card.all(:order => "rand()", :limit => 1).first
      new_day[:card] = { :name => card.name, :description => card.summary }
      new_day[:date] = Time.now
      update_attribute(:today, new_day)
      return new_day
    end
    self[:today]
  end

end
