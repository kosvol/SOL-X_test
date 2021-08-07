module EnvironmentSelector
  class << self
    def get_environment_url
      tmp_url = format($obj_env_yml[get_env_type_prefix.downcase][$current_application],
                       $current_environment)
      Log.instance.info tmp_url
      tmp_url
    end

    def get_env_type_prefix
      if $current_environment.include? "sit"
        "SIT"
      else
        "AUTO"
      end
    end

    def get_graphql_environment_url(key)
      format($obj_env_yml[get_env_type_prefix.downcase][key], $current_environment)
    end

    # def get_vessel_switch_url
    #   $obj_env_yml[$current_environment.to_s]['switch_vessel']
    # end

    # def get_update_master_pin_url
    #   $obj_env_yml[$current_environment.to_s]['update_mas_pin']
    # end
  end
end
