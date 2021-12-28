# frozen_string_literal: true

require_relative '../../../page_objects/precre/create_entry_permit_page'
require_relative '../../../page_objects/precre/pump_room_page'
#I (should|should not) see PRE landing screen
Then('PRE verify landing screen is {string}') do |text|
  @pre_page ||= PumpRoomPage.new(@driver)
  @pre_page.verify_pre_section_title(text, true)
end

#I (should|should not) see PRE landing screen
Then('PRE verify landing screen is not {string}') do |text|
  @pre_page ||= PumpRoomPage.new(@driver)
  @pre_page.verify_pre_section_title(text, false)
end

#I should see the right order of elements
Then('PRE verify questions order') do
  @pre_page ||= PumpRoomPage.new(@driver)
  @pre_page.verify_pre_questions
end

#I (should|should not) see alert message "(.*)" 1
Then('PRE verify alert message {string} does not show up') do |message|
  @pre_page ||= PumpRoomPage.new(@driver)
  @pre_page.verify_text_not_present(message)
end
#I (should|should not) see alert message "(.*)" 2
Then('PRE verify alert message {string}') do |message|
  @pre_page ||= PumpRoomPage.new(@driver)
  @pre_page.verify_error_msg(message)
end

#'I select Permit Duration {int}'
Then('PRE select Permit Duration {int}') do |duration|
  @pre_page ||= PumpRoomPage.new(@driver)
  @pre_page.select_permit_duration(duration)
end

#I select current day for field "([^"]*)"
Then('PRE select Date of Last Calibration as current day') do
  @pre_page ||= PumpRoomPage.new(@driver)
  @pre_page.select_calibration_date
end

#^I click (Yes|No|N/A) to answer the question "(.*)"
Then('PRE answer question') do |table|
  @pre_page ||= PumpRoomPage.new(@driver)
  params = table.hashes.first
  @pre_page.select_checkbox(params['answer'], params['question'])
end
#I (fill up|fill up with gas readings) (PRE.|CRE.) Duration (.*). Delay to activate (.*)
Then('PRE fill up permit') do |table|
  @pre_page ||= PumpRoomPage.new(@driver)
  params = table.hashes.first
  @pre_page.fill_pre_form(params['duration'])
  @pre_page.scroll_times_direction(1, 'down')
  @pre_page.activate_time_picker(params['delay to activate'])
end

And('PRE scroll {string} direction {int} times') do |times, direction|
  @pre_page ||= PumpRoomPage.new(@driver)
  @pre_page.scroll_times_direction(times, direction)
end

#I fill up PRE Duration 4 Delay to activate 3 with custom days 1 in Future from current
Then('PRE fill up permit in future') do |table|
  @pre_page ||= PumpRoomPage.new(@driver)
  params = table.hashes.first
  @pre_page.fill_pre_form(params['duration'])
  @pre_page.scroll_times_direction(1, 'down')
  @pre_page.select_day_in_future(params['days'])
  @pre_page.activate_time_picker(params['delay to activate'])
end

And('PRE verify scheduled date') do
  @pre_page ||= PumpRoomPage.new(@driver)
  @pre_page.verify_scheduled_date
end
