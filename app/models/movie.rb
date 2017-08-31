class Movie < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_attached_file :image, styles: { medium: "400x600#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  before_save :change_youtube_url

  def change_youtube_url
    self.description["https://www.youtube.com/watch?v="] = ""
    self.description = "https://www.youtube.com/embed/" + self.description
  end

end
