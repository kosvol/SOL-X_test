# frozen_string_literal: true

require_relative '../../../page_objects/entry_display_page'

And('EntryDisplay wait for permit') do |table|
  parms = table.hashes.first
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.wait_for_permit(parms['background'])
end


And('EntryDisplay check background color is {string}') do |condition|
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.check_background_color(condition)
end

And('EntryDisplay check entry display without new entry') do
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.check_without_new_entry
end

And('EntryDisplay check entry display with new entry') do
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.check_with_new_entry
end

And('EntryDisplay click enter new entry log button') do
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.check_with_new_entry
end

