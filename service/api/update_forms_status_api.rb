# frozen_string_literal: true

require 'rest-client'
# service to request submit master approval
class UpdateFormsStatusApi < BaseSectionApi
  def request(permit_id, status, pin)
    payload = create_payload(permit_id, status)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_id, status)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/update_form_status.json")
    payload['variables']['formId'] = permit_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    payload['variables']['newStatus'] = status
    payload
  end
end
