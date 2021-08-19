# frozen_string_literal: true

Then (/^I should see alert message$/) do
  BrowserActions.wait_until_is_visible(on(DashboardPage).gas_alert_element)
  BrowserActions.wait_until_is_visible(on(DashboardPage).gas_alert_accept_new_element)
  BrowserActions.wait_until_is_visible(on(DashboardPage).gas_alert_discard_new_element)
  BrowserActions.wait_until_is_visible(on(DashboardPage).gas_close_btn_element)
end

And (/^I click (accept|terminate) new gas readings on dashboard page$/) do |_condition|
  BrowserActions.poll_exists_and_click(on(DashboardPage).gas_alert_accept_new_element) if _condition == 'accept'
  BrowserActions.poll_exists_and_click(on(DashboardPage).gas_alert_discard_new_element) if _condition == 'terminate'
end