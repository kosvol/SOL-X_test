# frozen_string_literal: true

require 'rest-client'
# service to request section 6
class Section6Api < BaseSectionApi
  def request(permit_id, gas_reading, pin)
    payload = create_payload(permit_id, gas_reading)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_id, gas_reading)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/sections/6.section6_gas_testing_equipment.json")
    payload['variables']['formId'] = permit_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    update_answers(payload, gas_reading)
  end

  def update_answers(payload, gas_reading)
    payload['variables']['answers'][-2]['value'] = @user_service.create_default_signature('C/O', retrieve_vessel_name)
    update_gas_reading_answers(payload, gas_reading)
  end

  def update_gas_reading_answers(payload, gas_reading)
    if gas_reading == 'yes'
      payload['variables']['answers'][1].to_h['value'] = '"yes"'
      payload['variables']['answers'][-3]['value'] = @user_service.create_gas_reading('C/O', retrieve_vessel_name)
    else
      payload['variables']['answers'][1].to_h['value'] = '"no"'
    end
    payload
  end
end
