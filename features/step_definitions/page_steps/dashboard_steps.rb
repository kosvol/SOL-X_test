# frozen_string_literal: true

require_relative '../../../page_objects/dashboard_page'

And('Dashboard open dashboard page') do
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.open_page
end

And('Dashboard verify gas readings change alert') do
  @dashboard_page.verify_gas_reader_alert
end

And('Dashboard accept new gas readings') do
  @dashboard_page.accept_new_reading
end

And('Dashboard click terminate current permit') do
  @dashboard_page.terminate_current_permit
end

And('Dashboard click close gas readings message') do
  @dashboard_page.close_gas_reading_change
end

And('Dashboard verify entry status {string}') do |entry_status|
  @dashboard_page.verify_entry_status(entry_status)
end

And('Dashboard acknowledge gas reading change') do
  @dashboard_page.acknowledge_gas_change
end

And('Dashboard click Create GeoFence') do
  @dashboard_page.click_create_geofence
end

And('Dashboard click time button') do
  @dashboard_page.click_time_button
end

And('Dashboard verify the local time popup message') do
  @dashboard_page.verify_popup
end

And('Dashboard verify the local time') do
  @dashboard_page.verify_time_with_server
end

Then('Dashboard verify the time with offset is correct') do
  @dashboard_page.compare_time_offset
end
