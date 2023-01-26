# frozen_string_literal: true

require 'rest-client'
# cre update form answer api requests
class UpdateCreFormAnswerAPI < BaseSectionApi
  def initialize
    super
    @current_time = @time_service.retrieve_current_date_time
    @offset = @time_service.retrieve_ship_utc_offset
    @permit_duration = '4' # could be variable in the future
  end

  def request(permit_id, pin)
    create_payload(permit_id)
    response = RestClient.post(retrieve_api_url,
                               @payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_id)
    @payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/entry/cre/1.compressor_room_entry.json")
    @payload['variables']['formId'] = permit_id
    @payload['variables']['submissionTimestamp'] = @current_time

    # first entry time
    @payload['variables']['answers'][3]['value'] = "{\"dateTime\":\"#{@current_time}\",\"utcOffset\":#{@offset}}"
    update_signature
    update_time_property
  end

  def update_signature
    @payload['variables']['answers'][17]['value'] = @user_service.create_gas_reading('C/O', retrieve_vessel_name)
    @payload['variables']['answers'][21]['value'] =
      @user_service.create_default_signature('C/O', retrieve_vessel_name)
  end

  def update_time_property
    # start time
    @payload['variables']['answers'][18]['value'] =
      "{\"dateTime\":\"#{@current_time}\",\"utcOffset\":#{@offset}}"

    # end time
    @payload['variables']['answers'][19]['value'] =
      "{\"dateTime\":\"#{@time_service.retrieve_time_cal_hours(@permit_duration)}\",\"utcOffset\":#{@offset}}"

    # entry duration
    @payload['variables']['answers'][20]['value'] = "\"#{@permit_duration} hours\"" # entry duration
  end
end