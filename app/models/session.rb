class Session < ActiveRecord::Base
  before_validation :generate_token, on: :create

  belongs_to :user

  validates :token, uniqueness: true, presence: true
  validates :user, presence: true

  def self.authorize_user_with_token(token)
    session = Session.find_actual(token)
    raise AuthError.new unless session

    session
  end

  def self.authorize_user_with_credentials(email, password)
    user = User.find_by(email: email).try(:authenticate, password)
    raise AuthError.new unless user

    user.sessions.create!
  end

  protected

  @@token_size = ENV['AUTH_TOKEN_SIZE'].to_i

  @@token_timeout = ENV['AUTH_TOKEN_TIMEOUT'].to_i

  def generate_token
    self.token = loop do
      random_token = SecureRandom.base64(@@token_size)
      break random_token unless Session.exists?(token: random_token)
    end
  end

  def self.find_actual(token)
    where("created_at > ? AND token = ?",
      @@token_timeout.second.ago.utc, token).take
  end

end
