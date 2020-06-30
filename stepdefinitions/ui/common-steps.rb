# frozen_string_literal: true

Given (/^I launch sol-x portal$/) do
  step 'I unlink all crew from wearable'
  sleep 1
  $browser.get(EnvironmentSelector.get_environment_url)
  sleep 2
  # $browser.navigate.refresh
  # sleep 1
  $browser.navigate.refresh
  # puts "screen size: #{$browser.window_size}"
end

When (/^I navigate to "(.+)" screen$/) do |which_section|
  on(NavigationPage).tap_hamburger_menu
  on(NavigationPage).select_nav_category(which_section)
  sleep 1
  $browser.navigate.refresh
end
