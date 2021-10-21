# frozen_string_literal: true

require 'yaml'
# module for environment
module EnvUtils

  def retrieve_api_url
    env = ENV['ENVIRONMENT'][0..3]
    env_file = File.read("#{Dir.pwd}/config/environment.yml")
    config = YAML.safe_load(env_file)[env]
    api_url = config['service'] % ENV['ENVIRONMENT']
    raise if api_url.nil?

    api_url
  end

  def retrieve_vessel_name
    vessel_name = ENV['ENVIRONMENT'][4..6] + ENV['ENVIRONMENT'][0..3]
    vessel_name.upcase
  end

  def retrieve_env_url
    env = ENV['ENVIRONMENT'][0..3]
    application = ENV['APPLICATION']
    env_file = File.read("#{Dir.pwd}/config/environment.yml")
    YAML.safe_load(env_file)[env][application] % ENV['ENVIRONMENT']
  end
end
