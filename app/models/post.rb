class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  #normally, we do not need to be explicit, but because we are using "creator" instead of user, we have to be explicit to state:
  #the foreign_key and also the class name.
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories  
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true
  

  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size 
  end
end