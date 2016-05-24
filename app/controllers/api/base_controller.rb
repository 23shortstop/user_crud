class Api::BaseController < ::ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authorize_user

  rescue_from AccessError do |e|
    render_error('Access is denied', 403)
  end

  rescue_from AuthError do |e|
    render_error('Not Authorized', 401)
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render_error(e.message, 404)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render_error(e.message , 422)
  end

  def render_response(data, status = 200)
    render_json data, status
  end

  def render_error(message, status = 400)
    data = { error: message }
    render_json data, status
  end

  def authorize_user
    @current_session = authenticate_with_http_token do |token, options|
      Session.authorize_user_with_token token
    end

    raise AuthError.new unless @current_session
  end

  private

  def render_json(data, status)
    render json: data, status: status
  end

end