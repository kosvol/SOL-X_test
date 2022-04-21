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
