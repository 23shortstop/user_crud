class TaskProcessor
  include HTTParty
  include Sidekiq::Delay

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

  def get_result(task_id, processing_task_id)
    task = Task.find(task_id)
    response = self.class.get("/task/#{processing_task_id}")
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
      when :done
        task.set_result(body[:result])
      else
        self.delay_until(2.sec.from_now).get_result(task.id, body[:id])
    end
  end

  def handle_error(body, task)
    task.set_error(body[:error])
  end

end