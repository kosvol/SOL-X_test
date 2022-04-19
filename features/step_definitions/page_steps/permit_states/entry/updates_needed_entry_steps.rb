# frozen_string_literal: true

require_relative '../../../../../page_objects/permit_states/entry/updates_needed_entry_page'

And('UpdatesNeededEntry click Edit Update button') do
  @updates_needed_entry_page ||= UpdatesNeededEntryPage.new(@driver)
  @updates_needed_entry_page.click_edit_update(@permit_id)
end
