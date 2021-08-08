module EnvironmentSelector
  class << self
    def get_environment_url
      tmp_url = format($obj_env_yml[get_env_type_prefix.downcase][$current_application],
                       $current_environment)
      Log.instance.info tmp_url
      tmp_url
    end

    def get_env_type_prefix
      if $current_environment.include? 'sit'
        'SIT'
      else
        'AUTO'
      end
    end

    def get_permit_prefix
      case $current_environment
      when 'auto-cot'
        'AUTO'
      when 'sit-cot'
        'SIT'
      when 'sit-lng'
        'SITLNG'
      when 'sit-fsu'
        'SITFSU'
      end
    end

    def get_edge_db_data_by_uri(uri)
      format($obj_env_yml[get_env_type_prefix.downcase]['fauxton_url'], $current_environment) + uri
    end

    def get_service_url
      format($obj_env_yml[get_env_type_prefix.downcase]['service'], $current_environment)
    end

    def get_db_url(which_db, url_map)
      if which_db != 'cloud'
        get_edge_db_data_by_uri("#{$obj_env_yml[which_db.to_s][url_map.to_s]}")
      else
        $obj_env_yml[which_db.to_s]['base_cloud_url'] + $obj_env_yml[which_db.to_s][url_map.to_s]
      end
    end
  end
end
