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


