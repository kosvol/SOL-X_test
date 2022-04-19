# frozen_string_literal: true

require_relative '../../../../../page_objects/entry/entry_display/entry_display_page'

And('EntryDisplay wait for background update') do |table|
  parms = table.hashes.first
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.wait_for_background_update(parms['type'], parms['background'])
end

And('EntryDisplay verify new entry display') do |table|
  parms = table.hashes.first
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.verify_entry_log(parms['new_entry'])
end

# And('EntryDisplay wait for permit active') do
#   @entry_display = EntryDisplay.new(@driver)
#   @entry_display.wait_permit_active(@permit_id)
# end

# And('EntryDisplay check entry display without new entry') do
#   @entry_display = EntryDisplay.new(@driver)
#   @entry_display.check_without_new_entry
# end
#
# And('EntryDisplay check entry display with new entry') do
#   @entry_display = EntryDisplay.new(@driver)
#   @entry_display.check_with_new_entry
# end

And('EntryDisplay click enter new entry log button') do
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.click_new_entry_btn
end

And('EntryDisplay click {string} tab') do |condition|
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.click_entry_tab(condition)
end

And('EntryDisplay check entrants count {string}') do |count|
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.check_entrant_count(count)
end

# And('EntryDisplay check required entrants count {string}') do |count|
#   @entry_display = EntryDisplay.new(@driver)
#   @entry_display.check_required_entrants(count)
# end

# And('EntryDisplay check new permit number') do
#   @entry_display = EntryDisplay.new(@driver)
#   @entry_display.check_new_permit_num(@permit_id)
# end

And('EntryDisplay verify validity time') do
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.verify_validity_time
end

And('EntryDisplay verify creator {string}') do |creator|
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.verify_creator(creator)
end

And('EntryDisplay sign out first entrant') do
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.sign_out_first_entrant
end
