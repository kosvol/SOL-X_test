# frozen_string_literal: true

require 'rest-client'
# cre create form api requests
class CreateCreFormAPI < BaseSectionApi
  def request(pin)
    payload = create_payload
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/entry/cre/0.create_compressor_room_entry.json")
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    payload
  end
end
