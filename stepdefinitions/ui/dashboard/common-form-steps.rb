# frozen_string_literal: true

Then (/^I should see alert message$/) do
  BrowserActions.wait_until_is_visible(on(DashboardPage).gas_alert_element)
  BrowserActions.wait_until_is_visible(on(DashboardPage).gas_alert_accept_new_element)
  BrowserActions.wait_until_is_visible(on(DashboardPage).gas_alert_discard_new_element)
  BrowserActions.wait_until_is_visible(on(DashboardPage).gas_close_btn_element)
end

And (/^I click (accept|terminate|close) new gas readings on dashboard page$/) do |condition|
  BrowserActions.poll_exists_and_click(on(DashboardPage).gas_alert_accept_new_element) if condition == 'accept'
  BrowserActions.poll_exists_and_click(on(DashboardPage).gas_alert_discard_new_element) if condition == 'terminate'
  BrowserActions.poll_exists_and_click(on(DashboardPage).gas_close_btn_element) if condition == 'close'
end

