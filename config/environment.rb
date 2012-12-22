# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Reporter::Application.initialize!

CarrierWave.configure do |config|
  unless Rails.env.test?
    s3_config = YAML.load_file("#{Rails.root}/config/s3_config.yml")[Rails.env] rescue {}

    config.fog_credentials = {
      :provider               => 'AWS',       # required
      :aws_access_key_id      => s3_config['access_key_id'],       # required
      :aws_secret_access_key  => s3_config['secret_access_key'],       # required
      :region                 => 'eu-west-1'
    }
    config.fog_directory  = s3_config['bucket']                     # required
    config.asset_host     = "https://#{s3_config['bucket']}.s3.amazonaws.com"            # optional, defaults to nil
    config.fog_public     = true                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end
end