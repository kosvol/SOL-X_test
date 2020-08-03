# frozen_string_literal: true

Given (/^I launch sol-x portal$/) do
  step 'I unlink all crew from wearable'
  sleep 1
  $browser.get(EnvironmentSelector.get_environment_url)
  sleep 3
  # puts "screen size: #{$browser.window_size}"
end

Given (/^I launch sol-x portal without unlinking wearable$/) do
  $browser.get(EnvironmentSelector.get_environment_url)
  sleep 3
  # puts "screen size: #{$browser.window_size}"
end

When (/^I navigate to "(.+)" screen$/) do |_which_section|
  on(NavigationPage).tap_hamburger_menu
  on(NavigationPage).select_nav_category(_which_section)
  sleep 1
end

And ('I sleep for {int} seconds') do |sec|
  sleep sec
end

And (/^I click on back arrow$/) do
  on(SmartFormsPermissionPage).back_arrow_element.click
end
