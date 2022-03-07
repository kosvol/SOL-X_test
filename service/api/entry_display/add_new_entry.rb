# frozen_string_literal: true

require 'rest-client'
require_relative '../users_api'
require 'base64'

#  create new entry cre pre api requests
class CreateNewCrePreEntry < BaseSectionApi
  def request(pin, array)
    payload = create_payload(array)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(array)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/entry/1.add_cre_pre_entry.json")
    add_required_fields(payload)
    add_gas_readings(payload)
    add_entrants(array, payload)
    payload
  end

  def add_required_fields(payload)
    payload['variables']['formId'] = @permit_id
    encoded_string = Base64.encode64(File.open("#{Dir.pwd}/data/photos/signature.png", 'rb').read)
    payload['variables']['signature'] = "data:image/jpeg;base64, #{encoded_string}"
    payload['variables']['locationId'] = "#{retrieve_vessel_name}-Z-AFT-STATION"
    payload['variables']['crewId'] = retrieve_user_id_by_rank('C/O')
    payload
  end

  def add_gas_readings(payload)
    payload['variables']['gasReadings'] = default_gas_reading
    payload
  end

  def add_entrants(array, payload)
    array.split(',').each do |item|
      user_list = UsersApi.new.request
      user_list['data']['users'].each do |crew|
        if crew['crewMember']['rank'] == item
          payload['variables']['otherEntrantIds'].push(crew['_id'])
          break
        end
      end
    end
    payload
  end
end
