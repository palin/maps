CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.production?
    s3_config = YAML.load_file("#{Rails.root}/config/s3_config.yml")[Rails.env] rescue {}

    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET_ACCESS_KEY'],
      :region                 => 'eu-west-1'
    }
    config.fog_directory  = s3_config['bucket']                     # required
    config.asset_host     = "https://#{s3_config['bucket']}.s3.amazonaws.com"            # optional, defaults to nil
    config.fog_public     = true                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  elsif Rails.env.test?
    config.storage = :file
    config.enable_processing = false

    def store_dir
      "#{Rails.root}/uploads"
    end

    def cache_dir
      "#{Rails.root}/uploads"
    end
  end
end
