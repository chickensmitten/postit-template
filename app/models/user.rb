class User < ActiveRecord::Base

  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5} 
  #there is no password column, but there is a virtual attribute, 
  #the password must be present whenever I create a user object, this validation does not fire, when i update an existing user.
  sluggable_column :username

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end

end