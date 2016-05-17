class Api::UsersController < Api::BaseController

  def index
    render json: User.all
  end

  def show
    render json: find_user
  end

  def create
    user = User.new(user_params)
    user.save!
    render json: user
  end

  def update
    user = find_user
    user.update!(user_params)
    render json: user
  end

  def destroy
    user = find_user
    user.destroy
    render json: user
  end

  private

  def user_params
    params.permit(:name, :email)
  end

  def find_user
    User.find(params[:id])
  end

end
