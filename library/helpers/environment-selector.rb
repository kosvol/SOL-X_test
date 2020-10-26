# frozen_string_literal: true

module EnvironmentSelector
  class << self
    def get_environment_url
      p "URL: #{$obj_env_yml[get_environment.to_s][get_application.to_s]}"
      $obj_env_yml[get_environment.to_s][get_application.to_s]
    end

    def get_graphql_environment_url(key)
      $obj_env_yml[get_environment.to_s][key.to_s]
    end

    private

    def get_environment
      $current_platform = ENV['ENVIRONMENT']
    end

    def get_application
      $current_platform = ENV['APPLICATION']
    end
  end
end
