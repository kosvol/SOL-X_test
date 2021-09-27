# frozen_string_literal: true

require 'rest-client'
# service to request section3D
class Section3DAPI < BaseSectionApi

  def request(form_id, pin)
    payload = create_payload(form_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(form_id)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/3.section3d_DRA_summary_assessment.json")
    payload['variables']['formId'] = form_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    payload['variables']['answers'][-1]['value'] =
      @user_service.create_default_signature('C/O', retrieve_vessel_name)
    payload
  end
end
