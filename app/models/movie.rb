class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites,  dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :critics, through: :reviews, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations


  validates :title, :duration, :released_on, presence: true
  validates :description, length:{minimum: 25}
  validates :total_gross, numericality:{greater_than: 0}
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  }
  RATINGS = %w(G PG PG-13 R NC-17)
  validates :rating, inclusion: {in: RATINGS}

  def flop?
    total_gross.blank? || total_gross < 225_000_000 || reviews.size > 50 && average_stars >4
  end
  def self.released
    where("released_on < ?", Time.now).order("released_on desc")
  end
  def number_of_reviews
    reviews.size
    
  end
  def average_stars
    reviews.average(:stars) || 0.0
  end
  def stars_to_percentage
    self.average_stars/5.0 *100
  end

end
