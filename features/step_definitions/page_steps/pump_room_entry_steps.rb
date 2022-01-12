# frozen_string_literal: true

require_relative '../../../page_objects/precre/pump_room_entry_page'

Then('PRE verify landing screen is {string}') do |text|
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.verify_pre_section_title(text)
end

Then('PRE verify questions order') do
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.verify_pre_questions
end

Then('PRE verify alert message {string} does not show up') do |message|
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.verify_text_not_present(message)
end

Then('PRE verify alert message {string}') do |message|
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.verify_error_msg(message)
end

Then('PRE select Permit Duration {int}') do |duration|
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.select_permit_duration(duration)
end

Then('PRE select Date of Last Calibration as current day') do
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.select_calibration_date
end

Then('PRE answer question') do |table|
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  params = table.hashes.first
  @pump_room_entry_page.select_checkbox(params['answer'], params['question'])
end

Then('PRE fill up permit') do |table|
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  params = table.hashes.first
  @pump_room_entry_page.fill_pre_form(params['duration'])
  @pump_room_entry_page.scroll_times_direction(1, 'down')
  @pump_room_entry_page.activate_time_picker(params['delay to activate'])
end

And('PRE scroll {string} direction {int} times') do |times, direction|
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.scroll_times_direction(times, direction)
end

Then('PRE fill up permit in future') do |table|
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  params = table.hashes.first
  @pump_room_entry_page.fill_pre_form(params['duration'])
  @pump_room_entry_page.scroll_times_direction(1, 'down')
  @pump_room_entry_page.select_day_in_future(params['days'])
  @pump_room_entry_page.activate_time_picker(params['delay to activate'])
end

And('PRE verify scheduled date') do
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.verify_scheduled_date
end
