# frozen_string_literal: true

require 'rest-client'
# cre update form answer api requests
class UpdateCreFormAnswerAPI < BaseSectionApi
  def request(permit_id, pin)
    payload = create_payload(permit_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_id)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/cre/1.compressor_room_entry.json")
    payload['variables']['formId'] = permit_id
    current_time = @time_service.retrieve_current_date_time
    offset = @time_service.retrieve_ship_utc_offset
    payload['variables']['submissionTimestamp'] = current_time
    payload['variables']['answers'][4]['value'] = "{\"dateTime\":\"#{current_time}\",\"utcOffset\":#{offset}}"
    payload['variables']['answers'][7]['value'] = @user_service.create_gas_reading('C/O', retrieve_vessel_name)
    permit_duration = '4' # could be variable in the future
    payload['variables']['answers'][8]['value'] =
      "{\"dateTime\":\"#{@time_service.retrieve_time_cal_minutes(5)}\",\"utcOffset\":#{offset}}"
    payload['variables']['answers'][9]['value'] =
      "{\"dateTime\":\"#{@time_service.retrieve_time_cal_hours(permit_duration)}\",\"utcOffset\":#{offset}}"
    payload['variables']['answers'][10]['value'] = "\"#{permit_duration} hours\""
    payload['variables']['answers'][11]['value'] =
      @user_service.create_default_signature('C/O', retrieve_vessel_name)
    payload
  end
end
