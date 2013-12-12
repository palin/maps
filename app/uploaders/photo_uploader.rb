# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  class FilelessIO < StringIO
    attr_accessor :original_filename
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :full do
    process resize_to_fit: [1000, 1000]
  end

  version :medium do
    process resize_to_fit: [600, 600]
  end

  version :small do
    process resize_to_fit: [300, 300]
  end

  version :thumb do
    process resize_to_fill: [100, 100]
  end

  if Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def self.decode_photo(base64_img)
    begin
      tempfile = Tempfile.new("temp_report_file.jpg")
      tempfile.binmode
      tempfile << Base64.decode64(base64_img)

      file_string = ActionDispatch::Http::UploadedFile.new(
        tempfile: tempfile,
        filename: "rimg#{Digest::MD5.hexdigest(Time.now.to_s)}.jpg",
        original_filename: "rimg#{Digest::MD5.hexdigest(Time.now.to_s)}.jpg"
      )
    rescue => e
      nil
    end
  end
end
