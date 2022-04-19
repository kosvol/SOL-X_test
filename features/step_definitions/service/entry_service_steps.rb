# frozen_string_literal: true

require_relative '../../../service/form/entry/entry_service'
require_relative '../../../service/db_service'

Given('EntryService acknowledge new gas reading') do
  @entry_service ||= EntryService.new
  @entry_service.accept_new_gas_reading(@permit_id, @entry_id)
end

Given('EntryService create entry record') do |table|
  @entry_service ||= EntryService.new
  entry_response = @entry_service.create_entry_record(@permit_id, table)
  @entry_id = entry_response['data']['createEntryRecord'].first['entryId']
end

Given('EntryService verify no new gas reading') do
  @entry_service ||= EntryService.new
  @entry_service.verify_no_pending_record(@permit_id, @entry_id)
end

