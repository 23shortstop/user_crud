FactoryGirl.define do
  factory :task do
    user   { create :user }
    image  { create :image }

    factory :rotate_without_params do
      type :rotate

      factory :with_valid_rotate_params do
        params do
          { :angle => Faker::Number.between(0, 360) }
        end
      end

      factory :rotate_with_negative_angle do
        params { { :angle => -1 } }
      end

      factory :rotate_with_exceeding_angle do
        params { { :angle => 361 } }
      end

      factory :rotate_with_wrong_angle_type do
        params { { :angle => '90' } }
      end
    end

    factory :resize_without_params do
      type :resize

      factory :with_valid_resize_params do
        params do
          { :width => Faker::Number.number(3),
            :height => Faker::Number.number(3) }
        end
      end

      factory :resize_without_width do
        params { { :height => Faker::Number.number(3) } }
      end

      factory :resize_without_height do
        params { { :width => Faker::Number.number(3) } }
      end

      factory :resize_with_wrong_width do
        params { { :width => -1, :height => Faker::Number.number(3) } }
      end

      factory :resize_with_wrong_height do
        params { { :width => Faker::Number.number(3), :height => -1 } }
      end

      factory :resize_with_wrong_width_type do
        params { { :width => '100', :height => Faker::Number.number(3) } }
      end

      factory :resize_with_wrong_height_type do
        params { { :width => Faker::Number.number(3), :height => '100' } }
      end
    end
  end
end