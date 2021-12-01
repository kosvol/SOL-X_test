# frozen_string_literal: true

require_relative '../../../page_objects/precre/create_entry_permit_page'
require_relative '../../../page_objects/precre/compressor_room_page'


Then('CRE fill up permit') do |table|
  @cre_page ||= CompressorRoomPage.new(@driver)
  params = table.hashes.first
  @cre_page.fill_cre_form(params['duration'])
  @cre_page.scroll_times_direction(1, 'down')
  @cre_page.activate_time_picker(params['delay to activate'])
end

Then(/^CRE Verify form titles and questions$/) do
  @cre_page ||= CompressorRoomPage.new(@driver)
  @cre_page.verify_titles_and_questions
end

Then(/^CRE Verify form titles of sections$/) do
  @cre_page ||= CompressorRoomPage.new(@driver)
  @cre_page.verify_titles_of_sections
end

Then(/^CRE Verify form answers for questions$/) do
  @cre_page ||= CompressorRoomPage.new(@driver)
  @cre_page.verify_answers_of_sections_one
  @cre_page.verify_answers_of_sections_two
  @cre_page.verify_gas_sections
end

#I (should|should not) see PRE landing screen
Then('CRE verify landing screen is {string}') do |text|
  @cre_page ||= CompressorRoomPage.new(@driver)
  @cre_page.verify_cre_section_title(text, true)
end

#I (should|should not) see PRE landing screen
Then('CRE verify landing screen is not {string}') do |text|
  @cre_page ||= CompressorRoomPage.new(@driver)
  @cre_page.verify_cre_section_title(text, false)
end

