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
  @pump_room_entry_page.select_answer(table)
end

And('PumpRoomEntry verify scheduled date') do
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.verify_scheduled_date
end

And('PumpRoomEntry click Terminate') do
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.click_terminate_btn
end

And('PumpRoomEntry fill text area') do
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.fill_text_area
end

Then('PumpRoomEntry verify the fields are not editable') do
  @pump_room_entry_page ||= PumpRoomEntryPage.new(@driver)
  @pump_room_entry_page.verify_non_editable
end
