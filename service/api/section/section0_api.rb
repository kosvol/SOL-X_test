# frozen_string_literal: true

# service to request section0
require 'rest-client'
# section0 api request
class Section0API < BaseSectionApi
  def request(permit_type, pin)
    payload = create_payload(permit_type)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_type)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/section0/#{permit_type}.json")
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    payload
  end
end
