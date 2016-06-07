class TaskParamsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    message = 
    case record.operation
    when 'resize'

      case value
      when nil
        "params is reqquired"
      else
        width = value['width']
        height = value['height']

        if !width
          "param width is required"
        elsif !(width.kind_of?Fixnum)
          "param width should be a number"
        elsif width < 0
          "param width should be greater than zero"
        elsif !height
          "param height is required"
        elsif !(height.kind_of? Fixnum)
          "param height should be a number"
        elsif height < 0
          "param height should be greater than zero"
        end
      end

    when 'rotate'

      case value
      when nil
        'params is reqquired'
      else
        angle = value['angle']
        if !angle
          "param angle is required"
        elsif !(angle.kind_of? Fixnum)
          "param angle should be a number"
        elsif !angle.between?(0, 360)
          "param angle should be between 0 and 360"
        end
      end
      
    end

    if message
      record.errors[:params] << (options[:message] || message)
    end
  end
end