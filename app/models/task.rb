class Task < ActiveRecord::Base
    validates :image, presence: true
    validates :user, presence: true
    validates :status, presence: true
    validates :type, presence: true

    validates :params, task_params: true

    belongs_to :user
    belongs_to :image

    mount_uploader :result, ImageUploader
end
