class User < ApplicationRecord
  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :liked_movies, through: :favorites, source: :movie

  validates :name, :email, presence: true
  validates :email, format: {
    with: /\S+@\S+/,
    message: "Email must be a real Email",
    uniqueness: { case_sensitive: false }
  }
  validates :password, length: { minimum: 10, allow_blank: true }
  validates :username, format: {
    with: /\A[A-Z0-9]+\z/i,
    message: "may only contain letters and numbers",
    uniqueness: {case_sensitive: false}


  }


  
end
