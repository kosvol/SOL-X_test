# frozen_string_literal: true

require 'rest-client'
# service to request section1
class Section1API < BaseSectionApi
  def request(form_id, is_maintenance, pin)
    payload = create_payload(form_id, is_maintenance)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(form_id, is_maintenance)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/sections/1.section1_task_description.json")
    payload['variables']['formId'] = form_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    zone = "#{retrieve_vessel_name}-Z-AFT-STATION"
    payload['variables']['answers'].append({ "fieldId": 'locationOfWork',
                                             "typename": 'LocationFormAnswer',
                                             "value": "{\"zone\":\"#{zone}\",\"zoneDetails\":\"Test Automation\"}" })
    payload = update_main_answer(payload) if is_maintenance
    payload
  end

  def update_main_answer(payload)
    payload['variables']['answers'].append({ "fieldId": 'duration_of_maintenance_over_2_hours', "value": '"no"' })
    payload
  end
end
