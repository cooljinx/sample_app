class Relationship < ActiveRecord::Base
  attr_accessible :followed_id
  
  belongs_to :follower, :class_name => "User"    #  foreign key = follower_id
  belongs_to :followed, :class_name => "User"   # foreign key = followed_id

  validates :follower_id, :presence => true
  validates :followed_id, :presence => true

end
