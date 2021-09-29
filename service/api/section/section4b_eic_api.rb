# frozen_string_literal: true

require_relative '../../utils/time_service'
require_relative '../../utils/env_utils'
require 'rest-client'
# service to request Eic
class Section4bEicApi
  include EnvUtils

  def request(permit_id, pin)
    payload = create_payload(permit_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_id)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/4.section4b_eic.json")
    payload['variables']['parentFormId'] = permit_id
    payload['variables']['submissionTimestamp'] = TimeService.new.retrieve_current_date_time
    payload
  end
end
