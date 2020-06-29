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

Then (/^I should see crew list location indicator is (.+) 30s$/) do |indicator_color|
  step 'I link wearable'
  if indicator_color === 'green below'
    is_true(on(CrewListPage).is_activity_indicator_status('rgba(67, 160, 71, 1)'))
  end
  if indicator_color === 'yellow after'
    is_true(on(CrewListPage).is_activity_indicator_status('rgba(242, 204, 84, 1)'))
  end
end

Then (/^I should see crew location details on crew screen$/) do
  is_true(on(CrewListPage).is_location_details)
end

Then (/^I should see crew location (.+) details on crew screen$/) do |_location|
  is_true(on(CrewListPage).is_location_details(_location))
end

And (/^I view pin$/) do
  step 'I click on view pin button'
  sleep 1
  on(PinPadPage).enter_pin(1111)
  sleep 1
end

Then (/^I should see pin reviewed$/) do
  is_true(!on(CrewListPage).is_pin_hidden?)
end

And (/^I enter a non-existent pin$/) do
  step 'I click on view pin button'
  on(PinPadPage).enter_pin(1234)
end

And (/^I enter a invalid master pin$/) do
  step 'I click on view pin button'
  on(PinPadPage).enter_pin(1212)
end

And (/^I click on view pin button$/) do
  on(CrewListPage).view_pin_btn
end

And (/^I backspace on entered pin$/) do
  on(PinPadPage).backspace_once
end

Then (/^I should not see invalid pin message$/) do
  is_equal(on(PinPadPage).error_msg_element.text, 'Please Enter Your PIN')
end

Then (/^I should see not authorize error message$/) do
  is_equal(on(PinPadPage).error_msg_element.text, 'You Are Not Authorized To Perform That Action')
end

Then (/^I should see crews are sorted by descending order on seniority$/) do
  is_true(on(CrewListPage).is_crew_sorted_descending_seniority?)
end

And (/^I add an existing crew id$/) do
  on(CrewListPage).add_new_crew_btn
  on(CrewListPage).crew_id = 'SIT_SOLX0004'
  on(CrewListPage).retrieve_data_btn
end

Then (/^I should see duplicate crew error message$/) do
  is_equal('Unable to add crew to the crew list. Please enter a correct Crew ID.', on(CrewListPage).duplicate_crew_element.text)
end

Then (/^I should see Retrieve My Data button disabled$/) do
  on(CrewListPage).add_new_crew_btn
  is_true(!is_enabled?(on(CrewListPage).retrieve_data_btn_element))
end

And (/^I add crew (.+) id$/) do |crewid|
  on(CrewListPage).add_new_crew_btn
  on(CrewListPage).crew_id = crewid
  sleep 1
  on(CrewListPage).retrieve_data_btn
end

Then (/^I should see rank listing for (.+) showing 1 rank before and after$/) do |_current_rank|
  on(CrewListPage).is_rank_correctly_displayed?(_current_rank)
end
