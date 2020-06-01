# frozen_string_literal: true

When (/^I trigger crew assist$/) do
  step 'I link wearable'
  step 'I get wearable-simulator/mod-trigger-panic request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
end

And (/^I trigger second crew assist$/) do
  step 'I trigger crew assist'
end

Then (/^I should see two crew assist dialogs on dashboard$/) do
  is_equal(on(CrewAssistPage).crew_assist_dialogs_elements.size, 2)
end

Then (/^I should see crew assist popup display crew rank,name and location on dashboard$/) do
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  is_true(on(CrewAssistPage).is_crew_assist_dialog_details)
end

Then (/^I should crew location indicator is green$/) do
  is_true(on(CrewAssistPage).is_crew_location_indicator_green)
end
