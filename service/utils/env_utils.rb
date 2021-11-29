# frozen_string_literal: true

require 'yaml'
# module for environment
module EnvUtils

  def retrieve_api_url
    env = ENV['ENVIRONMENT']
    retrieve_env_file[env]['service'] % retrieve_prefix
  end

  def retrieve_db_url(db_type)
    case db_type
    when 'cloud'
      retrieve_env_file['cloud']['base_cloud_url']
    when 'edge'
      retrieve_env_file[ENV['ENVIRONMENT']]['couch_db'] % retrieve_prefix
    else
      "#{db_type} is not supported"
    end
  end

  def retrieve_vessel_name
    vessel_name = ENV['VESSEL'] + ENV['ENVIRONMENT']
    return "#{vessel_name}20".upcase if ENV['VERSION'] == '2.0'

    vessel_name.upcase
  end

  def retrieve_env_url
    retrieve_env_file[ENV['ENVIRONMENT']][ENV['APPLICATION']] % retrieve_prefix
  end

  def retrieve_env_file
    YAML.safe_load(File.read("#{Dir.pwd}/config/environment.yml"))
  end

  def retrieve_prefix
    prefix = "#{ENV['ENVIRONMENT']}#{ENV['VESSEL']}"
    prefix = (ENV['ENVIRONMENT']).to_s if ENV['APPLICATION'] == 'office_portal'
    return "#{prefix}-2-0" if ENV['VERSION'] == '2.0'

    prefix
  end
end
