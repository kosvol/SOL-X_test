# frozen_string_literal: true

require 'rest-client'
require_relative '../users_api'
require 'base64'

#  AcknowledgeGasReadings api requests
class AcknowledgeGasReadings < BaseSectionApi
  def request(pin, pre_number, entry_id)
    payload = create_payload(pre_number, entry_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(pre_number, entry_id)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/pre/02.acknowledge-entry-log.json")
    add_required_fields(payload, pre_number, entry_id)
    payload
  end

  def add_required_fields(payload, pre_number, entry_id)
    payload['variables']['formId'] = pre_number
    payload['variables']['entryId'] = entry_id
    payload
  end
end
