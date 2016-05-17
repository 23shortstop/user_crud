class Authentication < ActiveRecord::Base
  before_create :generate_token

  protected

  def generate_token
    self.token = loop do
      random_token = SecureRandom.base64(20)
      break random_token unless Authentication.exists?(token: random_token)
    end
  end

end
