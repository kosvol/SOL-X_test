# frozen_string_literal: true

require 'rest-client'
# service to request section 4b detail
class Section4bDetailApi < BaseSectionApi
  def request(permit_id, eic, pin)
    payload = create_payload(permit_id, eic)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(permit_id, eic)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/4.section4b_energy_isolation_certificate.json")
    payload['variables']['formId'] = permit_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    update_eic(payload, eic)
    payload
  end

  def update_eic(payload, eic)
    if eic == 'yes'
      payload['variables']['answers'][1].to_h['value'] = '"yes"'
      payload['variables']['answers'].last['value'] =
        @user_service.create_default_signature('C/O', retrieve_vessel_name)
    else
      payload['variables']['answers'][1].to_h['value'] = '"no"'
      payload['variables']['answers'].pop
    end
    payload
  end
end
