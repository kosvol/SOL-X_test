# frozen_string_literal: true

require_relative '../../../service/form/add_new_entry_generator'

Given('AddNewEntryRecord create new entry record with additional entrants') do |table|
  parms = table.hashes.first
  @add_new_entry_generator ||= AddNewEntryGenerator.new(parms['entry_type'])
  @add_new_entry_generator.create_entry_on_permit_display(parms['ranks'], parms['permit_status'])
end




