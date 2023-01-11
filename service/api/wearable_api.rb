# frozen_string_literal: true

require_relative '../../service/utils/env_utils'
# Wearable api requests
class WearableAPI
  include EnvUtils

  def retrieve_wearables(pin)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/wearable/wearable_details.json")
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  def link_crew_wearable(wearable_id, user_id, pin)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/wearable/link_crew_wearable.json")
    payload['variables']['wearableId'] = wearable_id
    payload['variables']['userId'] = user_id
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  def update_wearable_location(wearable_id, mac, pin)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/wearable/update_wearable_location.json")
    payload['variables']['id'] = wearable_id
    updated_payload = update_beacons(payload, mac)
    response = RestClient.post(retrieve_api_url,
                               updated_payload.to_json,
                               { 'Content-Type' => 'application/json', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  def unlink_wearable(wearable_id, pin)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/wearable/unlink_user_wearable.json")
    payload['variables']['id'] = wearable_id
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  def send_alert(wearable_id, pin)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/wearable/trigger_panic.json")
    payload['variables']['id'] = wearable_id
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  def dismiss_alert(wearable_id, pin)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/wearable/dismiss_panic.json")
    payload['variables']['id'] = wearable_id
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  def create_wearable(device_id, pin)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/wearable/create_wearable.json")
    payload['variables']['deviceId'] = device_id
    puts "!!! Its payload #{payload}"
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def update_beacons(payload, mac)
    payload['variables']['beacons'].first['mac'] = mac
    payload
  end
end
