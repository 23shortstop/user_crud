class Authentication < ActiveRecord::Base
  before_create :generate_token

  protected

  @@token_size = ENV['AUTH_TOKEN_SIZE'].to_i

  @@token_duration = ENV['AUTH_TOKEN_DURATION'].to_i

  def generate_token
    self.token = loop do
      random_token = SecureRandom.base64(@@token_size)
      break random_token unless Authentication.exists?(token: random_token)
    end
  end

  def self.find_actual(user, token)
    where("created_at > ? AND user_id = ? AND token = ?",
      @@token_duration.second.ago.utc, user.id, token).take
  end

end
