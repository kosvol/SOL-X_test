# frozen_string_literal: true

require_relative '../service/api/couch_db_api'

# db service
class DBService
  include EnvUtils

  def initialize
    @couch_db_api = CouchDBAPI.new
    @logger = Logger.new($stdout)
  end

  def retrieve_table(db_type, table)
    @couch_db_api.get_request(db_type, table)
  end

  def delete_table(db_type, table, table_response)
    payload = { docs: [] }
    vessel_name = retrieve_vessel_name
    table_response['rows'].each do |row|
      next unless row_data_match?(table, row, vessel_name)

      deleted_docs = { "_id": row['id'], "_rev": row['value']['rev'], "_deleted": true }
      payload[:docs].append(deleted_docs)
    end
    response = @couch_db_api.post_request(db_type, table, payload.to_json)
    @logger.info("delete form request response: #{response}")
  end

  private

  def row_data_match?(table, row, vessel_name)
    case table
    when 'office_approval_events'
      row['doc']['formId'].include? vessel_name
    when 'geofence'
      row['doc']['externalId'].include? vessel_name
    else
      row['id'].include? vessel_name
    end
  rescue StandardError # when key==nil return false
    false
  end
end
