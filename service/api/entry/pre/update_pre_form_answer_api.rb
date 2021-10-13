# frozen_string_literal: true

require 'rest-client'
# pre update form answer api requests
class UpdatePreFormAnswerAPI < BaseSectionApi
  def request(permit_id, pin)
    payload = create_payload(permit_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_id)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/pre/1.section1_pump_room_entry_permit.json")
    payload['variables']['formId'] = permit_id
    current_time = @time_service.retrieve_current_date_time
    offset = @time_service.retrieve_ship_utc_offset
    payload['variables']['submissionTimestamp'] = current_time
    payload['variables']['answers'][3]['value'] = "{\"dateTime\":\"#{current_time}\",\"utcOffset\":#{offset}}"
    payload['variables']['answers'][7]['value'] = @user_service.create_gas_reading('C/O', retrieve_vessel_name)
    permit_duration = '4' # could be variable in the future
    payload['variables']['answers'][21]['value'] =
      "{\"dateTime\":\"#{@time_service.retrieve_time_cal_minutes(5)}\",\"utcOffset\":#{offset}}"
    payload['variables']['answers'][22]['value'] =
      "{\"dateTime\":\"#{@time_service.retrieve_time_cal_hours(permit_duration)}\",\"utcOffset\":#{offset}}"
    payload['variables']['answers'][23]['value'] = "\"#{permit_duration} hours\""
    payload['variables']['answers'][24]['value'] =
      @user_service.create_default_signature('C/O', retrieve_vessel_name)
    payload
  end
end
