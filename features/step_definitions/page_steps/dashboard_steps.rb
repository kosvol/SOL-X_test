# frozen_string_literal: true

require_relative '../../../page_objects/dashboard_page'

And('Dashboard open dashboard page') do
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.open_page
end

And('Dashboard open new dashboard tab') do
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.open_new_page
end

And('Dashboard switch to {string} tab in browser') do |condition|
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.switch_browser_tab(condition)
end

And('Dashboard click view entry log button on dashboard') do
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.click_view_log_btn
end

And('Dashboard {string} permit date on entry log') do |condition|
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.save_check_log_date(condition)
end

And('Dashboard check active entrants number {string}') do |number|
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.check_active_entrants(number)
end

Then('Dashboard verify alert message {string} does not show up') do |message|
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.verify_text_not_present(message)
end

Then('Dashboard verify alert message {string}') do |message|
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.verify_error_msg(message)
end

Then('Dashboard verify gas readings acknowledge message') do
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.verify_ackn_message
end

Then('Dashboard click discard gas readings') do
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.click_discard_gr
end

Then('Dashboard click close gas readings message') do
  @dashboard_page ||= DashboardPage.new(@driver)
  @dashboard_page.click_close_gas_msg
end

