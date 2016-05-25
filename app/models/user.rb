class User < ActiveRecord::Base
  has_secure_password
  
  has_many :sessions
  has_many :images, as: :imageable

  validates :name, :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
end
