class Article < ActiveRecord::Base
  validates :title, :link, :image_url, presence: true
  has_many :reposts
end
