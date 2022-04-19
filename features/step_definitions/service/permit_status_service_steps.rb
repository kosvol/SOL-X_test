# frozen_string_literal: true

require_relative '../../../service/form/permit_status_service'

Given('PermitStatusService terminate active {string} entry permit') do |entry_type|
  entry_generator = PermitStatusService.new
  entry_generator.terminate_active_entry(entry_type)
end
