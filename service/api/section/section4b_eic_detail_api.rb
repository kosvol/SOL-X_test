# frozen_string_literal: true

require 'rest-client'
# service to request section 4b eic detail
class Section4bEicDetailApi < BaseSectionApi
  def request(permit_id, eic_id, pin)
    payload = create_payload(permit_id, eic_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_id, eic_id)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/sections/4.section4b_eic_cert_details.json")
    payload['variables']['parentFormId'] = permit_id
    payload['variables']['formId'] = eic_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    update_signature(payload)
  end

  def update_signature(payload)
    vessel_name = retrieve_vessel_name
    payload['variables']['answers'][-3]['value'] = @user_service.create_default_signature('C/O', vessel_name)
    payload['variables']['answers'][-2]['value'] = @user_service.create_default_signature('C/E', vessel_name)
    payload
  end
end
