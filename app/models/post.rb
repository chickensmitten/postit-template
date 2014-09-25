class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  #normally, we do not need to be explicit, but because we are using "creator" instead of user, we have to be explicit to state:
  #the foreign_key and also the class name.
  has_many :comments
end