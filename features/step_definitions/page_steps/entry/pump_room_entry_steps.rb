# frozen_string_literal: true

require_relative '../../../../page_objects/entry/pump_room_entry_page'

Then('PumpRoomEntry verify page title') do
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
end

Then('PumpRoomEntry verify questions') do
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.verify_pre_questions
end

Then('PumpRoomEntry select Permit Duration {int}') do |duration|
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.select_permit_duration(duration)
end

And('PumpRoomEntry {string} see Reporting interval') do |option|
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.verify_reporting_interval(option)
end

Then('PumpRoomEntry answer question') do |table|
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  params = table.hashes.first
  @pump_room_entry_page.select_checkbox(params['answer'], params['question'])
end

And('PumpRoomEntry verify scheduled date') do
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.verify_scheduled_date
end

And('PumpRoomEntry click Terminate') do
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.click_terminate_btn
end
