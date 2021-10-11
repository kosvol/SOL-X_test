# frozen_string_literal: true

module EnvironmentSelector
  class << self
    def environment_url
      tmp_url = format($obj_env_yml[env_type_prefix.downcase][$current_application],
                       $current_environment)
      Log.instance.info tmp_url
      tmp_url
    end

    def vessel_name
      if $current_environment.include? 'lng'
        "LNG#{env_type_prefix}"
      elsif $current_environment.include? 'cot'
        "COT#{env_type_prefix}"
      elsif $current_environment.include? 'fsu'
        "FSU#{env_type_prefix}"
      end
    end

    def vessel_type
      if $current_environment.include? 'lng'
        'LNG'
      elsif $current_environment.include? 'cot'
        'COT'
      elsif $current_environment.include? 'fsu'
        'FSU'
      else
        raise("Vessel type #{$current_environment} is not defined")
      end
    end

    def env_type_prefix
      if $current_environment.include? 'sit'
        'SIT'
      elsif $current_environment.include? 'auto'
        'AUTO'
      else
        $current_environment
      end
    end

    def get_edge_db_data_by_uri(uri)
      format($obj_env_yml[env_type_prefix.downcase]['fauxton_url'], $current_environment) + uri
    end

    def service_url
      format($obj_env_yml[env_type_prefix.downcase]['service'], $current_environment)
    end

    def oa_form_status
      $obj_env_yml['office_approval']['get_form_status']
    end

    def get_db_url(which_db, url_map)
      if which_db != 'cloud'
        get_edge_db_data_by_uri(($obj_env_yml[which_db.to_s][url_map.to_s]).to_s)
      else
        $obj_env_yml[which_db.to_s]['base_cloud_url'] + $obj_env_yml[which_db.to_s][url_map.to_s]
      end
    end

    def current_environment
      ENV['ENVIRONMENT']
    end
  end
end