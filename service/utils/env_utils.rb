# frozen_string_literal: true

require 'yaml'
# module for environment
module EnvUtils

  def retrieve_api_url
    env = ENV['ENVIRONMENT']
    env_file = File.read("#{Dir.pwd}/config/environment.yml")
    config = YAML.safe_load(env_file)
    if env.include? 'sit'
      config['sit']['service'] % env
    elsif env.include? 'uat'
      config['uat']['service'] % env
    else
      config['auto']['service'] % env
    end
  end

  def retrieve_vessel_name
    string_arr = ENV['ENVIRONMENT'].split('-')
    vessel_name = string_arr[1] + string_arr[0]
    vessel_name.upcase
  end
end
