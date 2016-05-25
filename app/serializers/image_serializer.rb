class ImageSerializer < BaseSerializer
  attributes :image

  def image
    object.image.url
  end
end
