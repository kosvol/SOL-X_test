# frozen_string_literal: true

require 'rest-client'
# service to request section1
class Section1API < BaseSectionApi
  def request(form_id, pin)
    payload = create_payload(form_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(form_id)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/1.section1_task_description.json")
    payload['variables']['formId'] = form_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    payload['variables']['answers'].last['value']['COTAUTO-Z-AFT-STATION'] = "#{retrieve_vessel_name}-Z-AFT-STATION"
    payload
  end
end
