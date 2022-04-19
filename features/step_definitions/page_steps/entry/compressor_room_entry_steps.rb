# frozen_string_literal: true

require_relative '../../../../page_objects/entry/compressor_room_entry_page'

And('CompressorRoomEntry verify form titles and questions') do
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_titles_and_questions
end

And('CompressorRoomEntry verify form titles of sections') do
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_titles_of_sections
end

And('CompressorRoomEntry verify form answers for questions') do
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
  @compressor_room_entry_page.verify_answers_of_sections_one
  @compressor_room_entry_page.verify_answers_of_sections_two
  @compressor_room_entry_page.verify_gas_sections
end

And('CompressorRoomEntry verify page title') do
  @compressor_room_entry_page ||= CompressorRoomEntryPage.new(@driver)
end
