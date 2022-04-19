# frozen_string_literal: true

require 'rest-client'
# pre create form api requests
class CreatePreFormAPI < BaseSectionApi
  def request(pin)
    payload = create_payload
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/entry/pre/0.create_pump_room_entry_permit.json")
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    payload
  end
end
