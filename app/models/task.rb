class Task < ActiveRecord::Base
  after_initialize :set_defaults

  validates :image, presence: true
  validates :user, presence: true
  validates :status, presence: true
  validates :operation, presence: true

  validates :params, task_params: true

  validates_inclusion_of :status,
    in: ['new', 'pending', 'done', 'error']

  validates_inclusion_of :operation,
    in: ['resize', 'rotate', 'negate']

  belongs_to :user
  belongs_to :image

  mount_uploader :result, ImageUploader

  def set_result(resulr_url)
    self.remote_result_url = resulr_url
    self.status = 'done'
    task.save!
  end

  def set_error(msg)
    self.update!(status: 'error', error: msg)
  end

  private

  def set_defaults
    self.status = 'new'
  end
end
