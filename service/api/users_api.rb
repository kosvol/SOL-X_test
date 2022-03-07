# frozen_string_literal: true

require_relative '../utils/time_service'
require_relative '../utils/env_utils'
require 'rest-client'
require 'json'
# api for retrieve users
class UsersApi
  include EnvUtils

  def request
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/retrieve_users.json")
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'x-auth-user' => 'system' })
    JSON.parse response.body
  end
end
