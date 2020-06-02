# frozen_string_literal: true

Then (/^I should see correct column headers$/) do
  is_equal(on(CrewListPage).get_crew_table_headers, '["Rank", "Crew ID", "Surname", "First Name", "Location", "View PINs"]')
end

Then (/^I should see total crew count match inactive crew$/) do
  step 'I get wearable-simulator/base-get-list-of-crew request payload'
  step 'I hit graphql'
  is_equal(on(CrewListPage).crew_list_elements.size, ServiceUtil.get_response_body['data']['crewMembers'].size)
  is_equal(on(CrewListPage).crew_count, on(CrewListPage).crew_list_elements.size)
end

Then (/^I should see pin hidden$/) do
  is_true(on(CrewListPage).is_pin_hidden)
end

Then (/^I should see all crew details match$/) do
  is_true(on(CrewListPage).get_crew_details)
end
