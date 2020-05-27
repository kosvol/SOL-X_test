# frozen_string_literal: true

module JsonUtil
  class << self
    def get_json_keys(json_response, keystore_arr)
      json_response.map do |key, value|
        keystore_arr << key.to_s
        Hash === value ? get_json_keys(value, keystore_arr) : key
        begin
          value.each do |item|
            get_json_keys(item.to_hash, keystore_arr)
          end
        rescue StandardError
          dump
        end
      end
      keystore_arr
    end

    @@request_payload_fpath = "../../../payload/request/"

    def read_json(filename)
      get_absolute_path = File.expand_path("#{@@request_payload_fpath}#{filename}.json", __FILE__)
      file = File.read(get_absolute_path)
    end

    def create_request_file(filename, request_body)
      file = File.open(File.expand_path("#{@@request_payload_fpath}#{filename}.json", __FILE__), "w")
      file.puts request_body.to_json
      file.close
    end

    @@response_payload_fpath = "../../../payload/response/"

    def create_response_file(filename, response_body, response_status_code)
      if response_status_code === 200
        FileUtils.mkdir_p(File.expand_path("#{filename.split("/").first}/", "payload/response"))
        file = File.open(File.expand_path("#{@@response_payload_fpath}#{filename}.json", __FILE__), "w")
        file.puts response_body
        file.close
      end
    end

    # def self.is_data_structure(which_service)
    #   get_response_data_structure(which_service)
    #   base_arr = get_base_data_structure(which_service)
    #   puts "\n\nGot: #{@@farmer.first(base_arr.size)}\n\n\n"
    #   puts "\n\nExpected: #{base_arr}\n\n\n"
    #   return (@@farmer.first(base_arr.size) === base_arr)
    # end

    # def self.get_base_data_structure(which_service)
    #   # if $current_application == "frontend" or $global_which_service == "authentication"
    #   return $obj_data_structure_yml[which_service]
    #   # else
    #   # return $obj_data_structure_yml[which_service]
    #   # end
    # end

    # def self.get_response_data_structure(which_service)
    #   @@farmer = []
    #   get_json_keys(ServiceUtil.get_response_body_json.to_hash,@@farmer)
    #   Log.instance.info "\n\nGot: #{@@farmer.to_s}\n\n\n"
    #   # Log.instance.info "\nExpected: #{get_base_data_structure(which_service).to_s}\n\n\n"
    #   return @@farmer
    # end
  end
end
