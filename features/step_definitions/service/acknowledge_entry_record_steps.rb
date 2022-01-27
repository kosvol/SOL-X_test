# frozen_string_literal: true

require_relative '../../../service/form/acknowledge_entry_record'
require_relative '../../../service/db_service'

Given('AcknowledgeEntry acknowledge existing gas entry record') do
  @acknowledge_entry ||= AcknowledgeEntryRecord.new
  @acknowledge_entry.acknowledge_entry_record(@permit_id, DBService.gas_entry_id)
end

