# frozen_string_literal: true

require 'rest-client'
# service to request RoL section 3 Task Status
class RolSection3TaskStAPI < BaseSectionApi
  def initialize
    super
    @current_time = @time_service.retrieve_current_date_time
    @utc_offset = @time_service.retrieve_ship_utc_offset
  end

  def request(permit_id, pin)
    payload = create_payload(permit_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_id)
    payload =
      JSON.parse File.read("#{Dir.pwd}/payload/request/form/sections/13.rol_section3_task_status.json")
    payload['variables']['formId'] = permit_id
    payload['variables']['submissionTimestamp'] = @current_time
    update_answers(payload)
  end

  def update_answers(payload)
    payload['variables']['answers'][2]['value'] =
      "{\"__typename\":\"DateTimeWithOffset\",\"dateTime\":\"#{@current_time}\",\"utcOffset\":#{@utc_offset}}"
    payload['variables']['answers'][5]['value'] = "{\"dateTime\":\"#{@current_time}\",\"utcOffset\":#{@utc_offset}}"
    payload['variables']['answers'][-3]['value'] = @user_service.create_section8_signature('C/O', retrieve_vessel_name)
    payload['variables']['answers'][-2]['value'] = @user_service.create_section8_signature('A/M', retrieve_vessel_name)
    payload
  end
end
