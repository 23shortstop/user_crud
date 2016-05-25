class Image < ActiveRecord::Base
    validates :image, presence: true
    
    belongs_to :imageable, polymorphic: true

    mount_uploader :image, ImageUploader
end
