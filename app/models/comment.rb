class Comment < ActiveRecord::Base
  include Voteable
  belongs_to :user
  belongs_to :post #no need to specify the foreign key here as the asumptions are correct.

  validates :body, presence: true

end