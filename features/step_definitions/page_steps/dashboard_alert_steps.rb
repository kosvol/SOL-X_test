# frozen_string_literal: true

require_relative '../../../page_objects/dashboard_alert_page'

And('DashboardAlert verify alert availability') do |table|
  params = table.hashes.first
  @dashboard_alert_page ||= DashboardAlertPage.new(@driver)
  @dashboard_alert_page.verify_alert_availability(params['alert'], params['availability'])
end

Then('DashboardAlert click Acknowledge button') do |table|
  params = table.hashes.first
  @dashboard_alert_page ||= DashboardAlertPage.new(@driver)
  @dashboard_alert_page.click_acknowledge_button(params['rank'])
end

Then('DashboardAlert verify crew assist alert data') do |table|
  params = table.hashes.first
  @dashboard_alert_page ||= DashboardAlertPage.new(@driver)
  @dashboard_alert_page.compare_ui_api_ca_data(params['rank'])
end
