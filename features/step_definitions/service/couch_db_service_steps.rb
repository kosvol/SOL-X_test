# frozen_string_literal: true

require_relative '../../../service/api/couch_db_service'

When('CouchDBService wait for form status get changed to {string} on {string}') do |state, server|
  couch_db_service ||= CouchDBService.new
  couch_db_service.wait_until_state(state.upcase, server.downcase, @permit_id)
end