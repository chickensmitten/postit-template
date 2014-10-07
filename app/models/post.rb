class Post < ActiveRecord::Base
  include Voteable
  include Sluggable

  belongs_to :user
  #normally, we do not need to be explicit, but because we are using "creator" instead of user, we have to be explicit to state:
  #the foreign_key and also the class name.
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories  

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  sluggable_column :title

end