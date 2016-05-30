FactoryGirl.define do
  factory :image do
    imageable   { create :user }
  end
end