# frozen_string_literal: true

module EnvironmentSelector
  class << self
    def get_environment_url
      p "URL: #{$obj_env_yml[$current_environment.to_s][$current_application.to_s]}"
      $obj_env_yml[$current_environment.to_s][$current_application.to_s]
    end

    def get_graphql_environment_url(key)
      $obj_env_yml[$current_environment.to_s][key.to_s]
    end

    def get_vessel_switch_url
      $obj_env_yml[$current_environment.to_s]['switch_vessel']
    end

    def get_update_master_pin_url
      $obj_env_yml[$current_environment.to_s]['update_mas_pin']
    end
  end
end
