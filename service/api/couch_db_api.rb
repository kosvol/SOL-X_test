# frozen_string_literal: true

require_relative '../../service/utils/env_utils'
# couch DB api
class CouchDBAPI
  include EnvUtils

  def get_request(db_type, table)
    response = RestClient.get("#{retrieve_db_url(db_type)}/#{table}/_all_docs?include_docs=true&skip=0&limit=10000")
    JSON.parse response.body
  end

  def post_request(db_type, table, payload)
    response = RestClient.post("#{retrieve_db_url(db_type)}/#{table}/_bulk_docs",
                               payload, 'Content-Type' => 'application/json')
    JSON.parse response.body
  end

  def get_custom_request(db_type, table, permit_id)
    response = RestClient.get("#{retrieve_db_url(db_type)}/#{table}/#{permit_id}")
    JSON.parse response.body
  end
end
