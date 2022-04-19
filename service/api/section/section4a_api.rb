# frozen_string_literal: true

require_relative '../../form/ptw/permit_map'
require 'rest-client'
# service to request section4A
class Section4AAPI < BaseSectionApi
  def request(form_id, permit_type, pin)
    payload = create_payload(form_id, permit_type)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(form_id, permit_type)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/sections/4.section4a_safety_checklist.json")
    update_checklist_answer(payload, permit_type)
    payload['variables']['formId'] = form_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    payload
  end

  def update_checklist_answer(payload, permit_type)
    checklist_key = PermitMap.new.retrieve_checklist_string(permit_type)
    payload['variables']['answers'].each do |answers|
      answers['value'] = 'yes' if answers['fieldId'] == checklist_key # find the field and update value
    end
  end
end
