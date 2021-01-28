# frozen_string_literal: true

Given(/^I launch Office Portal$/) do
  $browser.get(EnvironmentSelector.get_environment_url)
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).op_login_btn_element)
end

Then(/^I should see the "([^"]*)" name on the top bar and page body$/) do |name|
  is_equal(on(OfficePortalPage).topbar_header_element.text, name)
  is_equal(on(OfficePortalPage).portal_name_element.text, name)
  sleep(1)
end

When(/^I enter a (valid|invalid) password$/) do |_condition|
  if _condition === 'valid'
    on(OfficePortalPage).op_password_element.send_keys($password)
  else
    on(OfficePortalPage).op_password_element.send_keys('text')
  end
  sleep(1)
end

And(/^I click on Log In Now button$/) do
  on(OfficePortalPage).op_login_btn
  sleep(1)
end

Then(/^I should see the Vessel List page$/) do
  to_exists(on(OfficePortalPage).home_btn_element)
end
=begin
And(/^I see the checkbox is pre-checked$/) do
  is_selected(on(OfficePortalPage).remember_checkbox_element)
  sleep(10)
end

When(/^I uncheck the checkbox$/) do
  check_remember_checkbox
  sleep(1)
end

Then(/^I should see the checkbox is unchecked$/) do
  is_false(on(OfficePortalPage).remember_checkbox_element.selected?)
  sleep(1)
end
=end
