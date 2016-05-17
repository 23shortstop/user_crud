class Api::BaseController < ::ApplicationController

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

  private

  def render_json(data, status)
    render json: data, status: status
  end

end