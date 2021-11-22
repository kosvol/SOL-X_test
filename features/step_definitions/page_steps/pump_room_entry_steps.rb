# frozen_string_literal: true

require_relative '../../../page_objects/precre/create_entry_permit_page'
require_relative '../../../page_objects/precre/pump_room_page'

#I (should|should not) see PRE landing screen
Then(/^PRE verify PRE landing screen is (present|not present)$/) do |condition|
  @pre_page ||= PumpRoomPage.new(@driver)
  @pre_page.verify_pre_section_title(true) if condition.to_s.downcase == 'present'
  @pre_page.verify_pre_section_title(false) if condition.to_s.downcase == 'not present'
end
#I should see the right order of elements
Then(/^PRE verify questions order$/) do
  @pre_page ||= PumpRoomPage.new(@driver)
  base_data = YAML.load_file('data/pre/pump-room-entries.yml')['questions']
  @pre_page.verify_pre_questions(base_data)
end

#I (should|should not) see alert message "(.*)" 1
Then(/^PRE verify alert message "([^"]*)" doesn't show up$/) do |message|
  @pre_page.alert_not_present?(message)
end
#I (should|should not) see alert message "(.*)" 2
Then(/^PRE verify alert message "([^"]*)"$/) do |message|
  @pre_page.verify_error_msg(message)
end

#'I select Permit Duration {int}'
Then('PRE select Permit Duration {int}') do |duration|
  @pre_page.select_permit_duration(duration)
end

#I take note of start and end validity time for (.*)
And(/^PRE save current start and end validity time for (.*)$/) do |permit_type|
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.retrieve_start_end_time(permit_type.to_s)
end

#I select current day for field "([^"]*)"
Then(/^PRE select Date of Last Calibration as current day$/) do
  @pre_page ||= PumpRoomPage.new(@driver)
  @pre_page.select_calibration_date
end

#^I click (Yes|No|N/A) to answer the question "(.*)"
Then(/^PRE answer question$/) do |table|
  @pre_page ||= PumpRoomPage.new(@driver)
  params = table.hashes.first
  @pre_page.select_checkbox(params['answer'], params['question'])
end
#I (fill up|fill up with gas readings) (PRE.|CRE.) Duration (.*). Delay to activate (.*)
Then(/^PRE fill up permit$/) do |table|
  @pre_page ||= PumpRoomPage.new(@driver)
  params = table.hashes.first
  @pre_page.fill_pre_form(params['duration'])
  @pre_page.scroll_times_direction(1, 'down')
  @pre_page.activate_time_picker(params['delay to activate'])
end

#And(/^Get (PRE|CRE|PWT) id$/) do |permit_type|
And(/^PRE get permit id$/) do
  @create_entry_permit_page.retrieve_permit_id
end

#Then(/^I press the "([^"]*)" button$/) do |button|
Then(/^PRE click 'Submit for Approval' button$/) do
  @create_entry_permit_page.click_submit_for_approval
end
#And(/^I (should|should not) see Reporting interval$/) do |condition|
And(/^PRE verify Reporting interval doesn't show up$/) do
  @pre_page.scroll_times_direction(1, 'down')
  @create_entry_permit_page.verify_reporting_interval('disabled')
end

And(/^PRE verify Reporting interval$/) do
  @pre_page.scroll_times_direction(1, 'down')
  @create_entry_permit_page.verify_reporting_interval('enabled')
end
