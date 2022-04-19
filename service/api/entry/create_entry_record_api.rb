# frozen_string_literal: true

require 'rest-client'
require_relative '../../../service/utils/user_service'
require_relative '../../../service/utils/time_service'
require 'base64'

# CreateEntryRecordAPI requests
class CreateEntryRecordAPI
  include EnvUtils

  def initialize
    @user_service = UserService.new
  end

  def request(form_id, array, pin)
    payload = create_payload(form_id, array)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(form_id, array)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/entry/create_entry_record.json")
    update_answers(form_id, payload)
    add_gas_readings(payload)
    add_entrants(array, payload)
    payload
  end

  def update_answers(form_id, payload)
    payload['variables']['formId'] = form_id
    encoded_string = Base64.encode64(File.open("#{Dir.pwd}/data/photos/signature.png", 'rb').read)
    payload['variables']['signature'] = "data:image/jpeg;base64, #{encoded_string}"
    payload['variables']['locationId'] = "#{retrieve_vessel_name}-Z-AFT-STATION"
    payload['variables']['crewId'] = @user_service.retrieve_user_id_by_rank('C/O')
    payload
  end

  def add_gas_readings(payload)
    payload['variables']['gasReadings'] = @user_service.random_gas_reading
    payload['variables']['gasReadingEquipment']['gasLastCalibrationDate'] = TimeService.new.retrieve_current_date_time
    payload
  end

  def add_entrants(ranks_table, payload)
    ranks_table.raw.each do |rank|
      user_id = @user_service.retrieve_user_id_by_rank(rank[0])
      payload['variables']['otherEntrantIds'].push(user_id)
    end
    payload
  end
end
