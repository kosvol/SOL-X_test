# frozen_string_literal: true

require 'rest-client'
# service to request sra
class DraAPI < BaseSectionApi
  def request(permit_id, permit_type, pin)
    payload = create_payload(permit_id, permit_type)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_id, permit_type)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/dra/#{permit_type}.json")
    payload['variables']['parentFormId'] = permit_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    payload
  end
end
