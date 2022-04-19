# frozen_string_literal: true

require 'rest-client'
require_relative '../../service/api/update_forms_status_api'
# permit status service
class PermitStatusService
  def initialize
    @logger = Logger.new($stdout)
  end

  def retrieve_active_permit(type)
    payload = JSON.parse File.read("#{Dir.pwd}/payload/request/form/retrieve_active_permit.json")
    payload['variables']['types'].append(type)
    response = RestClient.post(retrieve_api_url, payload.to_json,
                               { 'Content-Type' => 'application/json', 'Accept' => '/', 'x-auth-pin' => '1111' })
    JSON.parse response.body
  end

  def terminate_active_entry(entry_type)
    permit_response = retrieve_active_permit(entry_type)
    return 'no active permit' if permit_response['data']['forms']['edges'].empty?

    active_permit_id = retrieve_active_permit(entry_type)['data']['forms']['edges'][0]['node']['_id']
    @logger.debug("active permit: #{active_permit_id}")
    response = UpdateFormsStatusApi.new.request(active_permit_id, 'CLOSED', '1111')
    @logger.debug("terminate active entry response: #{response}")
    response
  end
end
