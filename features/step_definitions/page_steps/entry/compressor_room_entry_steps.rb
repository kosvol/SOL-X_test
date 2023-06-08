# frozen_string_literal: true

require_relative '../../../../page_objects/entry/compressor_room_entry_page'

And('CompressorRoomEntry verify form titles and questions for {string}') do |entry_type|
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_titles_and_questions(entry_type)
end

And('CompressorRoomEntry verify form titles of sections for {string}') do |entry_type|
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_titles_of_sections(entry_type)
end

And('CompressorRoomEntry verify form answers for questions for {string}') do |entry_type|
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_answers_of_sections_one(entry_type)
  @compressor_room_entry_page.verify_answers_of_entry_titles(entry_type)
end

And('CompressorRoomEntry verify page title') do
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
end

And('CompressorRoomEntry fill text area') do
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.fill_text_area
end

Then('CompressorRoomEntry Select Location of vessel {string}') do |loc_type|
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.select_location_of_vessel(loc_type)
end

Then('CompressorRoomEntry answer all questions {string}') do |answer|
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.select_all_checkboxes(answer)
end

Then('CompressorRoomEntry verify the fields are not editable') do
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_non_editable
end

Then('CompressorRoomEntry select Permit Duration {int}') do |duration|
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.select_permit_duration(duration)
end

And('CompressorRoomEntry click Terminate') do
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.click_terminate_btn
end
