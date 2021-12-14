# frozen_string_literal: true

require 'yaml'
# module for environment
module EnvUtils
  BASE_URL = 'https://%<env>s.edge.%<project>s.safevue.ai'
  UI_PORT = '8080'
  API_PORT = '4000'
  EDGE_CREDENTIALS = 'admin:magellanx'
  CLOUD_CREDENTIALS = 'admin:gkmQjrP6Lmsd1tvZLTez'

  def generate_base_url
    project = if ENV['PROJECT'] == 'shell'
                'shell'
              else
                'solx'
              end
    format(BASE_URL, env: retrieve_prefix, project: project)
  end

  def retrieve_api_url
    "#{generate_base_url}:#{API_PORT}"
  end

  def retrieve_db_url(db_type)
    case db_type
    when 'cloud'
      "#{CLOUD_CREDENTIALS}@#{generate_base_url}"
    when 'edge'
      "#{EDGE_CREDENTIALS}@#{generate_base_url}:5984"
    else
      "#{db_type} is not supported"
    end
  end

  def retrieve_vessel_name
    vessel_name = ENV['VESSEL'] + ENV['ENVIRONMENT']
    return "#{vessel_name}20".upcase if ENV['VERSION'] == '2.0'
    return 'AAMIRA' if ENV['PROJECT'] == 'shell'

    vessel_name.upcase
  end

  def retrieve_env_url
    "#{generate_base_url}:8080"
  end

  def retrieve_env_file
    YAML.safe_load(File.read("#{Dir.pwd}/config/environment.yml"))
  end

  def retrieve_prefix
    prefix = "#{ENV['ENVIRONMENT']}#{ENV['VESSEL']}"
    return "#{prefix}-2-0" if ENV['VERSION'] == '2.0'

    prefix
  end
end
