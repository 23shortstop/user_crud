class Token < ActiveRecord::Base
  before_create :generate_token

  protected

  def generate_token
    self.token = loop do
      random_token = SecureRandom.base64(20)
      break random_token unless Token.exists?(token: random_token)
    end
  end

end
