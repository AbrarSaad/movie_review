class Movie < ApplicationRecord
  belongs_to :user
  has_many :reviews
  mount_uploader :image, PhotoUploader

  before_save :change_youtube_url

  def change_youtube_url
    if self.description.include?("https://www.youtube.com/watch?v=")
      self.description["https://www.youtube.com/watch?v="] = ""
      self.description = "https://www.youtube.com/embed/" + self.description
    end
  end

end
