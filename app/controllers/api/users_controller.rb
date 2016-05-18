class Api::UsersController < Api::BaseController
  before_action :find_and_authorize_user, only: [:show, :update, :destroy]

  def index
    render_response User.all
  end

  def show
    render_response @user
  end

  def create
    user = User.new(user_params)
    user.save!
    render_response user
  end

  def update
    @user.update!(user_params)
    render_response @user
  end

  def destroy
    @user.destroy
    render_response @user
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end

  def find_and_authorize_user
    @user = User.find(params[:id])
    authorization(@user)
  end

end
