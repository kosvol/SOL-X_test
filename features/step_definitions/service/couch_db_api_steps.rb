# frozen_string_literal: true

require_relative '../../../service/api/couch_db_api'

When ('CouchDBAPI wait for form status get changed to {string} on {string}') do |state, server|
  couch_db_api ||= CouchDBAPI.new
  couch_db_api.wait_until_state(state.upcase, server.downcase, @permit_id)
end