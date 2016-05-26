class Api::UsersController < Api::BaseController
  skip_before_action :authorize_user, only: :create
  before_action :find_user, only: [:show, :update, :destroy]
  before_action :restrict_access, only: [:show, :update, :destroy]

  def index
    render_response (paginate User.all)
  end

  def show
    render_response @user
  end

  def create
    user = User.new(user_params)
    user.save!
    render_response user, 201
  end

  def update
    @user.update!(user_params)
    render_response @user
  end

  def destroy
    @user.destroy
    render_response nil, 204
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def restrict_access
    raise AccessError.new unless @current_user == @user
  end

end
