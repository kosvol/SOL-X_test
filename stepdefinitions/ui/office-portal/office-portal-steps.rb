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
  not_to_exists(on(OfficePortalPage).permit_list_element)
end

And(/^I see the checkbox is (checked|unchecked)$/) do |condition|
  if condition == "checked"
    is_true(on(OfficePortalPage).remember_checkbox_element.checked?)
    sleep(1)
  else
    is_false(on(OfficePortalPage).remember_checkbox_element.checked?)
    sleep(1)
  end
end

When(/^I uncheck the checkbox$/) do
  on(OfficePortalPage).remember_box_element.click
  sleep(1)
end




Given(/^I log in to the Office Portal$/) do
  step 'I launch Office Portal'
  step 'I enter a valid password'
  step 'I click on Log In Now button'
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).home_btn_element)
end


Then(/^I should see the vessel name at the top bar and permits list$/) do
  does_include(on(OfficePortalPage).topbar_header_element.text, @vessel)
  does_include(on(OfficePortalPage).permits_list_name_element.text, @vessel)
  sleep(1)
end

When(/^I select the "([^"]*)" vessel$/) do |vessel|
  @vessel = vessel.upcase
  on(OfficePortalPage).select_vessel(@vessel)
  sleep(1)
end

And(/^I click on the Home icon$/) do
  on(OfficePortalPage).home_btn
  sleep(1)
end

And(/^I click on the Cross icon$/) do
  on(OfficePortalPage).permit_list_cross_btn_element.click
  sleep(1)
end

Then(/^I check the forms number on the vessel card$/) do
  @permitsNumber = on(OfficePortalPage).vessel_card_permits_number(@vessel)
end

And(/^I should sew the same number on the All Permits button$/) do
  does_include(on(OfficePortalPage).all_permits_btn_element.text, @permitsNumber)
end


