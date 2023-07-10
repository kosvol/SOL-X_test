# frozen_string_literal: true

require 'rest-client'
# service to request section3C
class Section3CAPI < BaseSectionApi
  def request(form_id, pin)
    payload = create_payload(form_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(form_id)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/sections/3.section3c_DRA_team_members.json")
    payload['variables']['formId'] = form_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    co_rank_id = @user_service.retrieve_user_id_by_rank('C/O')
    payload['variables']['answers'][1]['value'] = "[{\"userId\":\"#{co_rank_id}\",\"rank\":\"C/O\"}]"
    payload
  end
end
