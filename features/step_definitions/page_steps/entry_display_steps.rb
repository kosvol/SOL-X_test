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

And('EntryDisplay click {string} tab') do |condition|
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.click_entry_tab(condition)
end

And('EntryDisplay check entrants count {string}') do |count|
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.check_entrant_count(count)
end

And('EntryDisplay check required entrants count {string}') do |count|
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.check_required_entrants(count)
end

And('EntryDisplay click home tab') do
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.click_home_tab
end

And('EntryDisplay check entry log table') do
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.click_home_tab
end

And('EntryDisplay check new permit number') do
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.check_new_permit_num(@permit_id)
end

And('EntryDisplay check timer countdown') do
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.check_timer
end

And('EntryDisplay check') do |table|
  parms = table.hashes.first
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.check_response_officer(parms['rank'], parms['area'])
end
