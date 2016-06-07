FactoryGirl.define do
  factory :task do
    user   { create :user }
    status { :new }

    after(:build) do |task, eval|
      task.image = FactoryGirl.build(:image)
    end
  end

  trait :resize do
    operation { :resize }
    params do
     { :width => Faker::Number.number(3).to_i,
       :height => Faker::Number.number(3).to_i }
    end
  end

  trait :rotate do
    operation { :rotate }
    params do
      { :angle => Faker::Number.between(0, 360) }
    end
  end
end
