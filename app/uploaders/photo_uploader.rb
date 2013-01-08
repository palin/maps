# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :full do
    process :resize_to_fit => [1000, 1000]
  end

  version :medium do
    process :resize_to_fit => [600, 600]
  end

  version :small do
    process :resize_to_fit => [300, 300]
  end

  version :thumb do
    process :resize_to_fill => [100, 100]
  end

  if Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
