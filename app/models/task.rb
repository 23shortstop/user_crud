class Task < ActiveRecord::Base
    validates :image, presence: true
    validates :user, presence: true
    validates :status, presence: true
    validates :operation, presence: true

    validates :params, task_params: true

    validates_inclusion_of :status,
      in: ['new', 'pending', 'done']

    validates_inclusion_of :operation,
      in: ['resize', 'rotate', 'negate']

    belongs_to :user
    belongs_to :image

    mount_uploader :result, ImageUploader
end
