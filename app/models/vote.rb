class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true 
  #this is going to give us on the vote side a virtual attribute called voteable, 
  #a getter and setter for voteable
  #it requires an object
  #also, we have getters and setters for voteable id and voteable type, 

  validates_uniqueness_of :user, scope: [:voteable_id, :voteable_type]

end