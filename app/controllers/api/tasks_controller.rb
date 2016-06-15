require "./app/workers/task_worker"

class Api::TasksController < Api::BaseController
  before_action :find_task, only: [:show]
  before_action :restrict_task_access, only: [:show]
  before_action :find_image, only: [:create]
  before_action :restrict_image_access, only: [:create]

  def index
    tasks = @current_user.tasks

    render_response (paginate tasks)
  end

  def show
    render_response find_task
  end

  def create
    task = Task.new( { :image => @image,
                       :operation => params[:operation],
                       :params => params[:params],
                       :user => @current_user } )
    task.save!
    TaskWorker.perform_async(task.id)
    render_response task, 201
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def find_image
    @image = Image.find(params[:image])
  end

  def restrict_task_access
    raise AccessError.new unless @current_user == @task.user
  end

  def restrict_image_access
    raise AccessError.new unless @current_user == @image.imageable
  end

end
