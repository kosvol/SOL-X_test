# frozen_string_literal: true

require_relative '../../../page_objects/dashboard_entry_log_page'

And('DashboardEntryLog switch to {string} log') do |condition|
  @dashboard_entry_log_page ||= DashboardEntryLogPage.new(@driver)
  @dashboard_entry_log_page.select_entry_log_tab(condition)
end
