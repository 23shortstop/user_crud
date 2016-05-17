class Api::AuthenticationsController < Api::BaseController

  def create
    user = User.find_by_email!(log_in_params[:email])
    if user.authenticate(log_in_params[:password])
      render_response user.authentications.create
    else
      render_error 'Wrong password'
    end
  end

  private

  def log_in_params
    params.permit(:email, :password)
  end

end
