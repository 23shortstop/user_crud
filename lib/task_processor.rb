class TaskProcessor
  include HTTParty
  include Sidekiq::Extensions::Klass

  base_uri ENV['IMAGE_PROCESSOR_URI']
  format :json

  def process(task)
    params = {:operation => task.operation,
              :image => task.image.image.url,
              :params => task.params }

    task.update!(status: 'pending')

    response = self.class.post('/task', :query => params)
    handle response, task
  end

  def get_result(task_id, processing_task_id)
    task = Task.find(task_id)
    params = { :id => processing_task_id }
    response = self.class.get('/task', :query => params)
    handle response, task
  end

  private

  def handle(response, task)
    hash_body = JSON.parse(response.body)
    case response.code
      when 200 then handle_success(hash_body, task)
      else handle_error(hash_body, task)
    end
  end

  def handle_success(body, task)
    case body['status']
      when 'done'
        task.set_result(body['result'])
      else
        self.sidekiq_delay_until(Time.now + 2).get_result(task.id, body['id'])
    end
  end

  def handle_error(body, task)
    task.set_error(body['error'])
  end

end