require './lib/task_processor'

class TaskWorker
  include Sidekiq::Worker

  def initialize
    @task_processor = TaskProcessor.new
  end

  def perform(task_id)
    task = Task.find task_id

    @task_processor.process(task)
  end

end
