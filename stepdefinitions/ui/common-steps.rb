# frozen_string_literal: true

Given (/^I launch sol-x portal$/) do
  step 'I unlink all crew from wearable'
  sleep 1
  $browser.get(EnvironmentSelector.get_environment_url)
  sleep 5
  # puts "screen size: #{$browser.window_size}"
end

Given (/^I launch sol-x portal without unlinking wearable$/) do
  $browser.get(EnvironmentSelector.get_environment_url)
  sleep 5
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
  on(Section0Page).back_arrow_element.click
end

Then (/^I sign on canvas$/) do
  sleep 1
  on(Section3DPage).sign
end

And ('I enter pin {int}') do |pin|
  @@entered_pin = pin
  on(PinPadPage).enter_pin(pin)
  sleep 1
end

And (/^I press next for (.+) times$/) do |_times|
  (1.._times.to_i).each do |_i|
    sleep 1.5
    on(Section0Page).click_next
  end
end

When (/^I select (.+) permit$/) do |_permit|
  # sleep 1
  on(Section0Page).set_current_time
  on(Section0Page).click_permit_type_ddl
  sleep 1
  on(Section0Page).select_level1_permit(_permit)
end

When (/^I select (.+) permit for level 2$/) do |_permit|
  sleep 1
  on(Section0Page).select_level2_permit(_permit)
  sleep 1
  on(Section0Page).save_btn
  sleep 1
  on(Section0Page).set_selected_level2_permit(_permit)
end
