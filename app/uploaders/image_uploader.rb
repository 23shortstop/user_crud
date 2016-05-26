class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def move_to_store
    true
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{imageable_folder}"
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

  def imageable_folder
    "#{model.imageable_type.underscore}_#{model.imageable_id}"
  end

end
