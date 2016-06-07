class TaskSerializer < BaseSerializer
  attributes :id, :image, :status, :operation, :params, :result

  def image
    object.image.image.url
  end

  def result
    object.result.url
  end
end