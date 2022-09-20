# frozen_string_literal: true

require 'rest-client'
# service to request section 3 Withdrawal of permit
class RolSection3WithdrawnAPI < BaseSectionApi
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
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/sections/14.rol_section3_withdrawal_of_permit.json")
    payload['variables']['formId'] = permit_id
    payload['variables']['submissionTimestamp'] = @current_time
    payload['variables']['answers'].last['value'] = @user_service.create_default_signature('MAS', retrieve_vessel_name)
    payload
  end

  def update_answers(payload)
    payload['variables']['answers'].last['value'] = @user_service.create_default_signature('MAS', retrieve_vessel_name)
    payload
  end
end
