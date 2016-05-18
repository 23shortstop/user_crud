class Authentication < ActiveRecord::Base
  before_create :generate_token

  protected

  def generate_token
    self.token = loop do
      random_token = SecureRandom.base64(20)
      break random_token unless Authentication.exists?(token: random_token)
    end
  end

  def self.find_actual(user, token, duration)
    where("created_at > ? AND user_id = ? AND token = ?",
      duration.second.ago.utc, user.id, token).take
  end

end
