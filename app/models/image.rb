class Image < ActiveRecord::Base
  validates :image, presence: true
  validates :imageable, presence: true

  belongs_to :imageable, polymorphic: true
  has_many :tasks

  mount_uploader :image, ImageUploader
end
