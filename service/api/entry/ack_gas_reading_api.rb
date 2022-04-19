# frozen_string_literal: true

require 'rest-client'

#  AckGasReadingAPI requests
class AckGasReadingAPI
  include EnvUtils

  def request(pin, form_id, entry_id)
    payload = create_payload(form_id, entry_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(form_id, entry_id)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/pre/02.acknowledge-entry-log.json")
    update_answers(payload, form_id, entry_id)
    payload
  end

  def update_answers(payload, form_id, entry_id)
    payload['variables']['formId'] = form_id
    payload['variables']['entryId'] = entry_id
    payload
  end
end
