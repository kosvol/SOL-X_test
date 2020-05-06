module EnvironmentSelector
  class << self
    def get_environment_url
      $obj_env_yml["#{get_environment}"]["#{get_application}"]
    end

    def get_graphql_environment_url(key)
      $obj_env_yml["#{get_environment}"]["#{key}"]
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