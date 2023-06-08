# frozen_string_literal: true

require 'rest-client'
# service to request RoL section 1 DRA
class RolSection1API < BaseSectionApi
  def request(form_id, pin)
    payload = create_payload(form_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(form_id)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/sections/10.rol_section1_dra.json")
    payload['variables']['formId'] = form_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    payload['variables']['answers'][-3]['value'] =
      @user_service.create_default_signature('C/O', retrieve_vessel_name)
    payload
  end
end
