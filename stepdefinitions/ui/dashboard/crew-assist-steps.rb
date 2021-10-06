# frozen_string_literal: true

When(/^I trigger crew assist from wearable$/) do
  step 'I link wearable'
  step 'I get wearable-simulator/mod-trigger-panic request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
  sleep 3
end

And(/^I trigger second crew assist$/) do
  step 'I trigger crew assist from wearable'
end

Then(/^I should see two crew assist dialogs on dashboard$/) do
  is_equal(on(CrewAssistPage).crew_assist_dialogs_elements.size, 2)
end

Then(/^I should see crew assist popup display crew rank,name and location on dashboard$/) do
  sleep 1
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  is_true(on(CrewAssistPage).is_crew_assist_dialog_details)
end

Then(/^I should crew location indicator is red$/) do
  is_true(on(CrewAssistPage).is_crew_location_indicator_green)
end

And(/^I launch sol-x portal on another tab$/) do
  @browser.execute_script('window.open()')
  @browser.switch_to.window(@browser.window_handles.last)
  @browser.get(EnvironmentSelector.environment_url)
end

And('I acknowledge the assistance with pin {int}') do |_pin|
  sleep 1
  @browser
    .execute_script(%(document.evaluate("//div[starts-with(@class, 'CrewAssistModal__Content')]/button",document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()))
  step 'I enter pin for rank MAS'
end

And('I acknowledge the assistance with invalid pin {int}') do |pin|
  sleep 1
  @browser
    .execute_script(%(document.evaluate("//div[starts-with(@class, 'CrewAssistModal__Content')]/button", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()))
  step "I enter pure pin #{pin}"
end

Then(/^I should see crew assist dialog dismiss in both tab$/) do
  sleep 3
  is_equal(on(CrewAssistPage).crew_assist_dialogs_elements.size, 0)
  @browser.switch_to.window(@browser.window_handles.first)
  is_equal(on(CrewAssistPage).crew_assist_dialogs_elements.size, 0)
end

And(/^I dismiss crew assist from wearable$/) do
  step 'I get wearable-simulator/mod-dismiss-panic request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
end

Then(/^I should see invalid pin message$/) do
  is_equal(on(PinPadPage).error_msg_element.text, 'Incorrect Pin, Please Enter Again')
end

And(/^I dismiss enter pin screen$/) do
  on(PinPadPage).cancel_pinpad
end

Then(/^I should not see crew assist dialog$/) do
  sleep 1
  is_equal(on(CrewAssistPage).crew_assist_dialogs_elements.size, 0)
end

When(/^I refresh the browser$/) do
  @browser.navigate.refresh
end
