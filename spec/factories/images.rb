FactoryGirl.define do
  factory :image do
    imageable   { create :user }
    image       { Faker::Placeholdit.image }
  end
end