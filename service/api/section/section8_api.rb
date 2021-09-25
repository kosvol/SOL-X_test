# frozen_string_literal: true

require 'rest-client'
# service to request section 8
class Section8Api < BaseSectionApi

  def request(permit_id, pin)
    payload = create_payload(permit_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_id)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/8.section8_task_status_and_EIC_normalisation.json")
    current_time = @time_service.retrieve_current_date_time
    utc_offset = @time_service.retrieve_ship_utc_offset
    payload['variables']['formId'] = permit_id
    payload['variables']['submissionTimestamp'] = current_time
    payload['variables']['answers'][2].to_h['value'] =
      "{\"dateTime\":\"#{current_time}\",\"utcOffset\":#{utc_offset}}"
    payload['variables']['answers'][4].to_h['value'] = '"Completed"'
    payload['variables']['answers'][5].to_h['value'] =
      "{\"dateTime\":\"#{current_time}\",\"utcOffset\":#{utc_offset}}"
    payload['variables']['answers'][-2]['value'] =
      @user_service.create_default_signature('C/O', retrieve_vessel_name)
    payload
  end
end
