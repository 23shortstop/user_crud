class Api::ImagesController < Api::BaseController
  before_action :set_image, only: [:show, :update, :destroy]
  before_action :restrict_access, only: [:show, :update, :destroy]

  def index
    images = @current_user.images

    render_response (paginate images)
  end

  def show
    render_response @image
  end

  def create
    image = @current_user.images.create
    image.remote_image_url = image_params
    image.save!

    render_response image
  end

  def update
    @image.update!(image_params)
    render_response @image
  end

  def destroy
    @image.destroy

    render_response @image
  end

  private

    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params[:image]
    end

    def restrict_access
      raise AccessError.new unless @current_user == @image.imageable
    end
end
