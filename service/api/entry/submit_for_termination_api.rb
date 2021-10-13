# frozen_string_literal: true

require 'rest-client'
# pre submit for termination api requests
class SubmitForTerminationAPI < BaseSectionApi
  def request(permit_id, entry_type, pin)
    payload = create_payload(permit_id, entry_type)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_id, entry_type)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/#{entry_type}/3.submit_for_termination.json")
    payload['variables']['formId'] = permit_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    payload['variables']['answers'][0]['value'] =
      @user_service.create_default_signature('C/O', retrieve_vessel_name)
    payload
  end
end

