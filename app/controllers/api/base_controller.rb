class Api::BaseController < ::ApplicationController

  class AuthError < StandardError
  end

  rescue_from AuthError do |e|
    render_error('Access is denied', 403)
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

  def authorization(user)
    token = request.headers["Authorization"]
    duration = 3000
    authorization = Authentication.find_actual(user, token, duration)
    raise AuthError unless authorization
  end

  private

  def render_json(data, status)
    render json: data, status: status
  end

end