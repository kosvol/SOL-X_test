# frozen_string_literal: true

require_relative '../../../service/form/entry/entry_generator'
Given('EntryGenerator create entry permit') do |table|
  parms = table.hashes.first
  entry_generator = EntryGenerator.new(parms['entry_type'])
  parms['creator_rank'] = 'C/O' if parms['creator_rank'].nil?

  case parms['permit_status']
  when 'PENDING_OFFICER_APPROVAL'
    entry_generator.create_pending_approval(parms['creator_rank'])
  when 'ACTIVE'
    entry_generator.create_active(parms['creator_rank'])
  when 'UPDATES_NEEDED'
    entry_generator.create_updates_needed(parms['creator_rank'])
  when 'TERMINATED'
    entry_generator.create_terminated(parms['creator_rank'])
  else
    raise "status #{parms['permit_status']} is not supported"
  end
  @permit_id = entry_generator.permit_id
end
