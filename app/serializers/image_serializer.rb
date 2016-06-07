class ImageSerializer < BaseSerializer
  attributes :id, :image

  def image
    object.image.url
  end
end
