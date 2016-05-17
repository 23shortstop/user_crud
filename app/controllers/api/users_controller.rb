class Api::UsersController < Api::BaseController

  def index
    render_response User.all
  end

  def show
    render_response find_user
  end

  def create
    user = User.new(user_params)
    user.save!
    render_response user
  end

  def update
    user = find_user
    user.update!(user_params)
    render_response user
  end

  def destroy
    user = find_user
    user.destroy
    render_response user
  end

  private

  def user_params
    params.permit(:name, :email)
  end

  def find_user
    User.find(params[:id])
  end

end
