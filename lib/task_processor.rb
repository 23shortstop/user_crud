class TaskProcessor
  include HTTParty
  base_uri ENV['IMAGE_PROCESSOR_URI']
  format :json

  def process(task)
    params = {:operation => task.operation,
              :image => task.image.image.url,
              :params => task.params }.to_json

    task.update!(status: 'pending')

    response = self.class.post('/task', :body => params)
    handle response, task
  end

  def get_result(task)
    response = self.class.get("/task/#{task.id}")
    handle response, task
  end

  private

  def handle(response, task)
    case response.code
      when 200 then handle_success(response.body, task)
      else handle_error(response.body, task)
    end
  end

  def handle_success(body, task)
    case body[:status]
      when :pending
        self.delay_until(2.sec.from_now).get_result(task)
      when :done
        task.set_result(body[:result])
    end
  end

  def handle_error(body, task)
    task.set_error(body[:error])
  end

end