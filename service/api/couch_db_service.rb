# frozen_string_literal: true

# couch DB service
class CouchDBService
  def wait_until_state(what_status, server, permit_id)
    iteration = 16
    status = nil
    while iteration.positive? && status != what_status.to_s
      request = CouchDBAPI.new.request_form_by_permit_id(server, permit_id)
      docs = (JSON.parse request.to_s)['docs']
      status = docs[0]['status'] if docs != []
      iteration -= 1
      sleep(20)
    end
    @logger = Logger.new($stdout)
    @logger.debug(status)
  end
end
