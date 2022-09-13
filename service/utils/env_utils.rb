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
      retrieve_cloud_url
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

  def retrieve_date_from
    date_from = ENV['DATEFROM']
    return "#{date_from}"

  end

  def retrieve_days
    days = ENV['DAYS']
    return "#{days}"

  end

  def retrieve_steps_disable
    steps_dsbl = ENV['STEPSOFF']
    return "#{steps_dsbl}"

  end

  def retrieve_heart_disable
    heart_dsbl = ENV['HEARTOFF']
    return "#{heart_dsbl}"

  end

  def retrieve_heat_disable
    heat_dsbl = ENV['HEATOFF']
    return "#{heat_dsbl}"

  end

  def retrieve_cotsit_enable
    cotsit_enbl = ENV['COTSIT']
    return "#{cotsit_enbl}"

  end

  def retrieve_fsusit_enable
    fsusit_enbl = ENV['FSUSIT']
    return "#{fsusit_enbl}"

  end

  def retrieve_lngsit_enable
    lngsit_enbl = ENV['LNGSIT']
    return "#{lngsit_enbl}"

  end

  def retrieve_cotauto_enable
    cotauto_enbl = ENV['COTAUTO']
    return "#{cotauto_enbl}"

  end

  def retrieve_fsuauto_enable
    fsuauto_enbl = ENV['FSUAUTO']
    return "#{fsuauto_enbl}"

  end

  def retrieve_lngauto_enable
    lngauto_enbl = ENV['LNGAUTO']
    return "#{lngauto_enbl}"

  end

  def retrieve_cotsit20_enable
    cotsit20_enbl = ENV['COTSIT20']
    return "#{cotsit20_enbl}"

  end

  def retrieve_fsusit20_enable
    fsusit20_enbl = ENV['FSUSIT20']
    return "#{fsusit20_enbl}"

  end

  private

  def retrieve_cloud_url
    cloud_env =
      if (ENV['ENVIRONMENT'] == 'sit') || (ENV['ENVIRONMENT'] == 'auto')
        'sit'
      else
        'uat'
      end
    format(BASE_URL, env: "#{CLOUD_CREDENTIALS}@couchdb-#{cloud_env}", server: 'cloud', project: ENV['PROJECT'])
  end

end
