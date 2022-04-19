# frozen_string_literal: true

require_relative '../../../../../page_objects/entry/entry_display/entry_log_page'

And('EntryLog verify entry log table') do
  @entry_log_page = EntryLogPage.new(@driver)
  @entry_log_page.verify_entry_log_table
end

And('EntryLog verify first entrant out time') do
  @entry_log_page = EntryLogPage.new(@driver)
  @entry_log_page.verify_first_entrant_time
end
