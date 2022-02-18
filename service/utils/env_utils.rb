# frozen_string_literal: true

require 'yaml'
# module for environment
module EnvUtils
  BASE_URL = 'https://%<env>s.%<server>s.%<project>s.safevue.ai'
  UI_PORT = '8080'
  API_PORT = '4000'
  EDGE_CREDENTIALS = 'admin:magellanx'
  CLOUD_CREDENTIALS = 'admin:gkmQjrP6Lmsd1tvZLTez'

  def generate_base_url
    server = ENV['APPLICATION'] == 'office_portal' ? 'cloud' : 'edge'
    format(BASE_URL, env: retrieve_prefix, server: server, project: ENV['PROJECT'])
  end

  def retrieve_api_url
    if ENV['APPLICATION'] == 'office_portal'
      "#{format(BASE_URL, env: "#{ENV['ENVIRONMENT']}#{ENV['VESSEL']}", server: 'edge',
                          project: ENV['PROJECT'])}:#{API_PORT}"
    else
      "#{generate_base_url}:#{API_PORT}"
    end
  end

  def retrieve_db_url(db_type)
    case db_type
    when 'cloud'
      format(BASE_URL, env: "#{CLOUD_CREDENTIALS}@couchdb-sit",
                       server: db_type, project: ENV['PROJECT'])
    when 'edge'
      format(BASE_URL, env: "#{EDGE_CREDENTIALS}@#{retrieve_prefix}",
                       server: db_type, project: ENV['PROJECT']).insert(-1, ':5984')
    else
      "#{db_type} is not supported"
    end
  end

  def retrieve_vessel_name
    vessel_name = ENV['VESSEL'] + ENV['ENVIRONMENT']
    return 'AAMR' if ENV['PROJECT'] == 'shell'
    return "#{vessel_name}20".upcase if ENV['VERSION'] == '2.0'

    vessel_name.upcase
  end

  def retrieve_env_url
    if ENV['APPLICATION'] == 'office_portal'
      generate_base_url
    else
      "#{generate_base_url}:#{UI_PORT}"
    end
  end

  def retrieve_env_file
    YAML.safe_load(File.read("#{Dir.pwd}/config/environment.yml"))
  end

  def retrieve_prefix
    if ENV['APPLICATION'] == 'office_portal'
      'office-sit'
    elsif ENV['VERSION'] == '2.0'
      "#{ENV['ENVIRONMENT']}#{ENV['VESSEL']}-2-0"
    else
      "#{ENV['ENVIRONMENT']}#{ENV['VESSEL']}"
    end
  end
end
