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
    update_users(payload)
    update_answers(payload)
  end

  def update_signature(payload)
    vessel_name = retrieve_vessel_name
    payload['variables']['answers'][-4]['value'] = @user_service.create_default_signature('C/O', vessel_name)
    payload['variables']['answers'][-3]['value'] = @user_service.create_default_signature('A/M', vessel_name)
    payload['variables']['answers'][-2]['value'] = @user_service.create_default_signature('C/E', vessel_name)
    payload
  end

  def update_users(payload)
    co_rank_id = @user_service.retrieve_user_id_by_rank('C/O')
    payload['variables']['answers'][11]['value'] = "[{\"userId\":\"#{co_rank_id}\",\"rank\":\"C/O\"}]"
    payload['variables']['answers'][19]['value'] = "[{\"userId\":\"#{co_rank_id}\",\"rank\":\"C/O\"}]"
    payload
  end

  def update_answers(payload)
    zone = "#{retrieve_vessel_name}-Z-AFT-STATION"
    payload['variables']['answers'][12]['value'] = "{\"zoneList\":[\"#{zone}\"],\"zoneDetails\":\"Test Automation\"}"
    payload['variables']['answers'][13]['value'] = "{\"zoneList\":[\"#{zone}\"],\"zoneDetails\":\"Test Automation\"}"
    payload
  end
end
