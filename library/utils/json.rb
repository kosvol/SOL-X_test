# frozen_string_literal: true

module JsonUtil
  class << self
    def get_json_keys(json_response, keystore_arr)
      json_response.map do |key, value|
        keystore_arr << key.to_s
        value.is_a?(Hash) ? get_json_keys(value, keystore_arr) : key
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

    @@request_payload_fpath = '../../../payload/request/'

    def read_json(filename)
      get_absolute_path = File.expand_path("#{@@request_payload_fpath}#{filename}.json", __FILE__)
      file = File.read(get_absolute_path)
    end

    def create_request_file(filename, request_body)
      file = File.open(File.expand_path("#{@@request_payload_fpath}#{filename}.json", __FILE__), 'w')
      file.puts request_body.to_json
      file.close
    end

    @@response_payload_fpath = '../../../payload/response/'

    def read_json_response(filename)
      get_absolute_path = File.expand_path("#{@@response_payload_fpath}#{filename}.json", __FILE__)
      file = File.read(get_absolute_path)
    end

    def create_response_file(filename, response_body, response_status_code)
      if response_status_code === 200
        FileUtils.mkdir_p(File.expand_path("#{filename.split('/').first}/", 'payload/response'))
        file = File.open(File.expand_path("#{@@response_payload_fpath}#{filename}.json", __FILE__), 'w')
        file.puts response_body.to_s.encode('utf-8', invalid: :replace, undef: :replace, replace: '_')
        file.close
      end
    end
  end
end
