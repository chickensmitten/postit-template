class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post #no need to specify the foreign key here as the asumptions are correct.

  validates :body, presence: true

end