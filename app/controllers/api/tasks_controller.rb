class Api::TasksController < Api::BaseController
  before_action :find_task, only: [:show]
  before_action :restrict_access, only: [:show]

  def index
    tasks = @current_user.tasks

    render_response (paginate tasks)
  end

  def show
    render_response @task
  end

  def create
    task = Task.new( { :image => Image.find(params[:image]),
                       :operation => params[:operation],
                       :params => params[:params].as_json,
                       :user => @current_user } )
    task.save!
    render_response task, 201
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def restrict_access
    raise AccessError.new unless @current_user == @task.user
  end

end
