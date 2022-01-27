# frozen_string_literal: true

require_relative '../../../page_objects/entry_display_page'
require_relative '../../../page_objects/precre/entry_display_page'

And('EntryDisplay wait for permit') do |table|
  parms = table.hashes.first
  @entry_display_ptw = EntryDisplayPTW.new(@driver)
  @entry_display_ptw.wait_for_permit(parms['background'])
end

And('EntryDisplay check background color is {string}') do |condition|
  @entry_display_ptw = EntryDisplayPTW.new(@driver)
  @entry_display_ptw.check_background_color(condition)
end

And('EntryDisplay check entry display without new entry') do
  @entry_display_ptw = EntryDisplayPTW.new(@driver)
  @entry_display_ptw.check_without_new_entry
end

And('EntryDisplay check entry display with new entry') do
  @entry_display_ptw = EntryDisplayPTW.new(@driver)
  @entry_display_ptw.check_with_new_entry
end

And('EntryDisplay click enter new entry log button') do
  @entry_display_ptw = EntryDisplayPTW.new(@driver)
  @entry_display_ptw.check_with_new_entry
end

And('EntryDisplay click {string} tab') do |condition|
  @entry_display_ptw = EntryDisplayPTW.new(@driver)
  @entry_display_ptw.click_entry_tab(condition)
end

And('EntryDisplay check entrants count {string}') do |count|
  @entry_display_ptw = EntryDisplayPTW.new(@driver)
  @entry_display_ptw.check_entrant_count(count)
end

And('EntryDisplay check required entrants count {string}') do |count|
  @entry_display_ptw = EntryDisplayPTW.new(@driver)
  @entry_display_ptw.check_required_entrants(count)
end

And('EntryDisplay click home tab') do
  @entry_display_ptw = EntryDisplayPTW.new(@driver)
  @entry_display_ptw.click_home_tab
end

And('EntryDisplay check entry log table') do
  @entry_display_ptw = EntryDisplayPTW.new(@driver)
  @entry_display_ptw.click_home_tab
end

And('EntryDisplay check entry log table') do
  @entry_display_ptw = EntryDisplayPTW.new(@driver)
  @entry_display_ptw.check_all_log_tbl
end

And('EntryDisplayPage signout entrants by order {string}') do |count|
  @entry_display_ptw = EntryDisplayPage.new(@driver)
  @entry_display_ptw.signout_entrants_by_order(count)
end

And('EntryDisplayPage signout entrants by rank {string}') do |rank|
  @entry_display_ptw = EntryDisplayPage.new(@driver)
  @entry_display_ptw.signout_entrants_by_name(rank)
end

