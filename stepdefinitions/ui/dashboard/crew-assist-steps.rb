# frozen_string_literal: true

When (/^I trigger crew assist from wearable$/) do
  step 'I link wearable'
  step 'I get wearable-simulator/mod-trigger-panic request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
end

And (/^I trigger second crew assist$/) do
  step 'I trigger crew assist from wearable'
end

Then (/^I should see two crew assist dialogs on dashboard$/) do
  is_equal(on(CrewAssistPage).crew_assist_dialogs_elements.size, 2)
end

Then (/^I should see crew assist popup display crew rank,name and location on dashboard$/) do
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  is_true(on(CrewAssistPage).is_crew_assist_dialog_details)
end

Then (/^I should crew location indicator is red$/) do
  is_true(on(CrewAssistPage).is_crew_location_indicator_green)
end

And (/^I launch sol-x portal on another tab$/) do
  $browser.execute_script('window.open()')
  $browser.switch_to.window($browser.window_handles.last)
  $browser.get(EnvironmentSelector.get_environment_url)
end

And (/^I acknowledge the assistance with pin (.+)$/) do |pin|
  on(CrewAssistPage).acknowledge_btn
  on(PinPadPage).enter_pin(pin)
end

Then (/^I should see crew assist dialog dismiss in both tab$/) do
  is_equal(on(CrewAssistPage).crew_assist_dialogs_elements.size, 0)
  $browser.switch_to.window($browser.window_handles.first)
  is_equal(on(CrewAssistPage).crew_assist_dialogs_elements.size, 0)
end

And (/^I dismiss crew assist from wearable$/) do
  step 'I get wearable-simulator/mod-dismiss-panic request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
end

Then (/^I should see invalid pin message$/) do
  is_equal(on(PinPadPage).error_msg_element.text, 'Incorrect Pin, Please Enter Again')
end

And (/^I dismiss enter pin screen$/) do
  on(PinPadPage).cancel
end

Then (/^I should not see crew assist dialog$/) do
  is_equal(on(CrewAssistPage).crew_assist_dialogs_elements.size, 0)
end

When (/^I refresh the browser$/) do
  $browser.navigate.refresh
end
