# frozen_string_literal: true

require 'rest-client'
# service to request section3B
class Section3BAPI < BaseSectionApi

  def request(form_id, pin)
    payload = create_payload(form_id)
    response = RestClient.post(retrieve_api_url,
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => pin })
    JSON.parse response.body
  end

  private

  def create_payload(form_id)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/3.section3b_DRA_checks_measures.json")
    payload['variables']['formId'] = form_id
    payload['variables']['submissionTimestamp'] = @time_service.retrieve_current_date_time
    master_rank_id = @user_service.retrieve_user_id_by_rank('MAS')
    payload['variables']['answers'][2]['value'] = "[{\"userId\":\"#{master_rank_id}\",\"rank\":\"MAS\"}]"
    payload
  end

end
