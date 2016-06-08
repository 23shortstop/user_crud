class TaskProcessor
  include HTTParty
  base_uri ENV['IMAGE_PROCESSOR_URI']
  format :json

  def process(task)
    params = {:operation => task.operation,
              :image => task.image.url,
              :params => task.params }.to_json

    handle post('/task', :body => params), task
  end

  def get_result(task)
    handle get("/task/#{task.id}"), task
  end

  private

  def handle(response, task)
    case response.code
      when 200 handle_success(response.body, task)
      else handle_error(response.body, task)
    end
  end

  def handle_success(body, task)
    task.set_result(body(:result)) if body(:status) == :done
  end

  def handle_error(body, task)
    task.set_error(body(:error))
  end

end