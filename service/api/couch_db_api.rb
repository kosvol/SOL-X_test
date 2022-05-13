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
    response = RestClient.post("#{retrieve_db_url(db_type)}/#{table}",
                               payload, 'Content-Type' => 'application/json')
    JSON.parse response.body
  end

  def request_bulk_docs(db_type, table, payload)
    response = RestClient.post("#{retrieve_db_url(db_type)}/#{table}/_bulk_docs",
                               payload, 'Content-Type' => 'application/json')
    JSON.parse response.body
  end

  def request_form_by_permit_id(db_type, permit_id)
    payload = { selector: { _id: permit_id } }.to_json.to_s
    RestClient.post("#{retrieve_db_url(db_type)}/forms/_find", payload, 'Content-Type' => 'application/json')
  end

  def request_changes(db_type, table)
    response = RestClient.get("#{retrieve_db_url(db_type)}/#{table}/_changes")
    JSON.parse response.body
  end

  def request_purge(db_type, table, payload)
    response = RestClient.post("#{retrieve_db_url(db_type)}/#{table}/_purge",
                               payload, 'Content-Type' => 'application/json')
    JSON.parse response.body
  end

  def request_compact(db_type, table)
    response = RestClient.post("#{retrieve_db_url(db_type)}/#{table}/_compact",
                               {}.to_json, 'Content-Type' => 'application/json')
    JSON.parse response.body
  end
end
