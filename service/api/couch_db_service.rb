# frozen_string_literal: true

# couch DB service
class CouchDBService

  def wait_until_state(what_status, server, permit_id)
    iteration = 16
    status = nil
    while iteration.positive? && status != what_status.to_s
      request = CouchDBAPI.new.request_to_server(server, permit_id)
      docs = (JSON.parse request.to_s)['docs']
      status = docs[0]['status'] if docs != []
      iteration -= 1
      sleep(20)
    end
    Log.instance.info(status)
  end

end