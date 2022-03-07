# frozen_string_literal: true

require_relative '../../../service/form/entry_generator'
Given('EntryGenerator create entry permit') do |table|
  parms = table.hashes.first
  entry_generator = EntryGenerator.new(parms['entry_type'])
  entry_generator.create_entry(parms['permit_status'])
  @permit_id = entry_generator.permit_id
end
