FactoryGirl.define do
  factory :task do
    user   { create :user }
    image  { create :image }

    factory :task_with_valid_resize_params do
      type :resize
      params do
        { :width => Faker::Number.number(3),
          :height => Faker::Number.number(3) }
      end
    end

    sequence :tasks_with_invalid_resize_params do
      invalid_params = [
        nil,
        { :width => Faker::Number.number(3) },
        { :height => Faker::Number.number(3) },
        { :width => -1, :height => Faker::Number.number(3) },
        { :width => Faker::Number.number(3), :height => -1 },
        { :width => '100', :height => Faker::Number.number(3) },
        { :width => Faker::Number.number(3), :height => '100' }
      ]

      invalid_params.map do |p|
        create(:task, :type => :resize, :params => p)
      end
    end

    factory :with_valid_rotate_params do
      type :rotate
      params do
        { :angle => Faker::Number.between(0, 360) }
      end
    end

    sequence :with_invalid_rotate_params do
      invalid_params = [
        nil,
        { :angle => -1 },
        { :angle => 361 },
        { :angle => '90' },
      ]

      invalid_params.map do |p|
        create(:task, :type => :rotate, :params => p)
      end
    end

  end

end