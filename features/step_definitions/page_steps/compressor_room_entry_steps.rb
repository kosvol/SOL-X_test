# frozen_string_literal: true

require_relative '../../../page_objects/precre/compressor_room_entry_page'


Then('CRE fill up permit') do |table|
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  params = table.hashes.first
  @compressor_room_entry_page.fill_cre_form(params['duration'])
  @compressor_room_entry_page.scroll_times_direction(1, 'down')
  @compressor_room_entry_page.activate_time_picker(params['delay to activate'])
end

Then(/^CRE verify form titles and questions$/) do
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_titles_and_questions
end

Then(/^CRE verify form titles of sections$/) do
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_titles_of_sections
end

Then(/^CRE verify form answers for questions$/) do
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_answers_of_sections_one
  @compressor_room_entry_page.verify_answers_of_sections_two
  @compressor_room_entry_page.verify_gas_sections
end

#I (should|should not) see PRE landing screen
Then('CRE verify landing screen is {string}') do |text|
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_cre_section_title(text)
end

#Then I will see popup dialog with C/O LNG C/O crew rank and name
Then('CRE verify gas added by {string}') do |text|
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_gas_added_by(text)
end

#Then I should see that existed CRE number not equal with number Active list
Then('CRE verify permit not present in list') do
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_permit_not_in_list
end
