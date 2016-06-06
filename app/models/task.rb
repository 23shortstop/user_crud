class Task < ActiveRecord::Base
    validates :image, presence: true
    validates :user, presence: true
    validates :status, presence: true

    belongs_to :user

    mount_uploader :result, ImageUploader
end
