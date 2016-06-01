FactoryGirl.define do
  factory :session do
    user  { create :user }
    token { SecureRandom.base64 }
  end
end