# frozen_string_literal: true

Then(/^I should see correct column headers$/) do
  p ">> #{on(CrewListPage).crew_table_headers_list}"
  is_equal(on(CrewListPage).crew_table_headers_list,
           '["Rank", "Surname", "First Name", "Location", "PIN", "Work Availability*", "Rank", "Surname", "First Name",
 "Location", "PIN", "Work Availability*", "", "", "", "", "", "", "", "", "", ""]')
end

Then(/^I should see total crew count match inactive crew$/) do
  is_equal(on(CrewListPage).crew_count, (on(CrewListPage).crew_list_elements.size / 2))
end

Then(/^I should see pin hidden$/) do
  is_true(on(CrewListPage).pin_hidden?)
end

Then(/^I should see all crew details match$/) do
  is_true(on(CrewListPage).get_crew_details)
end

Then(/^I should see crew list location indicator is (.+) 5 minutes$/) do |indicator_color|
  step 'I link wearable'
  is_true(on(CrewListPage).activity_indicator_status?('rgba(67, 160, 71, 1)')) if indicator_color == 'green below'
  is_true(on(CrewListPage).activity_indicator_status?('rgba(242, 204, 84, 1)')) if indicator_color == 'yellow after'
end

Then(/^I should see crew location details on crew screen$/) do
  step 'I sleep for 2 seconds'
  is_true(on(CrewListPage).location_details?)
end

Then(/^I should see crew location (.+) details on crew screen$/) do |location|
  is_true(on(CrewListPage).location_details?(location))
end

And(/^I view pin$/) do
  step 'I click on view pin button'
  step 'I enter pin for rank MAS'
end

Then(/^I (should|should not) see pin reviewed$/) do |condition|
  is_true(!on(CrewListPage).pin_hidden?) if condition == 'should not'
  is_true(!on(CrewListPage).pin_reviewed?) if condition == 'should'
end

And(/^I enter a non-existent pin$/) do
  step 'I click on view pin button'
  step 'I enter pure pin 1234'
end

And(/^I enter a invalid master pin$/) do
  step 'I click on view pin button'
  step 'I enter pin for rank C/O'
end

And(/^I click on view pin button$/) do
  BrowserActions.poll_exists_and_click(on(CrewListPage).view_pin_btn_element)
end

And(/^I backspace on entered pin$/) do
  on(PinPadPage).backspace_once
end

Then(/^I should see not authorize error message$/) do
  is_equal(on(PinPadPage).error_msg_element.text, 'You Are Not Authorized To Perform That Action')
end

Then(/^I should see crews are sorted by descending order on seniority$/) do
  is_true(on(CrewListPage).crew_sorted_desc_seniority?)
end

And(/^I add an existing crew id$/) do
  on(CrewListPage).add_new_crew_btn
  on(CrewListPage).crew_id = 'AUTO_SOLX0004'
  on(CrewListPage).retrieve_data_btn
end

Then(/^I should see duplicate crew error message$/) do
  is_equal('Unable to add crew to the crew list. Please enter a correct Crew ID.',
           on(CrewListPage).duplicate_crew_element.text)
end

And(/^I add crew$/) do
  BrowserActions.poll_exists_and_click(on(CrewListPage).add_new_crew_btn_element)
  on(CrewListPage).crew_id = 'CDEV_SOLX0002'
  BrowserActions.poll_exists_and_click(on(CrewListPage).retrieve_data_btn_element)
  BrowserActions.poll_exists_and_click(on(CrewListPage).view_crew_pin_btn_element)
  sleep 1
  CommonPage.set_entered_pin = on(CrewListPage).pin_text_field_element.text
  BrowserActions.poll_exists_and_click(on(CommonFormsPage).done_btn_elements.first)
end

And(/^I add crew (.+) id$/) do |crew|
  on(CrewListPage).add_new_crew_btn
  on(CrewListPage).crew_id = crew
  BrowserActions.poll_exists_and_click(on(CrewListPage).retrieve_data_btn_element)
end

Then(/^I should see rank listing for (.+) showing 1 rank before and after$/) do |current_rank|
  is_true(on(CrewListPage).rank_correctly_displayed?(current_rank))
end

And(/^I change the crew rank$/) do
  on(CrewListPage).change_crew_rank
end

Then(/^I should see pin review$/) do
  is_true(on(CrewListPage).pin_viewed?)
end

Then(/^I should see count down start from 10 seconds$/) do
  case on(CrewListPage).countdown_elements[0].text
  when 'Hiding in 9 secs'
    true
  when 'Hiding in 8 secs'
    true
  when 'Hiding in 7 secs'
    true
  else
    raise "Wrong count down text >>> #{on(CrewListPage).countdown_elements[0].text}"
  end
end

When(/^I create the ptw with the new pin$/) do
  step 'I navigate to "SmartForms" screen for forms'
  step 'I navigate to create new permit'
  step "I enter pure pin #{CommonPage.return_entered_pin}"
end