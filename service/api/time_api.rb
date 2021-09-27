# frozen_string_literal: true

require_relative '../utils/time_service'
require_relative '../utils/env_utils'
require 'rest-client'
# api for retrieve users
class TimeApi
  include EnvUtils

  def request_ship_local_time(pin = '1111')
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/retrieve_ship_local_time.json")
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

end
