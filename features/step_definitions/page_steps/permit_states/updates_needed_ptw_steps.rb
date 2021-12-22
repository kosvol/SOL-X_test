# frozen_string_literal: true
require_relative '../../../../page_objects/permit_states/updates_needed_ptw_page'

And('UpdatesNeeded click Edit Update button') do
  @updates_needed ||= UpdatesNeededPTWPage.new(@driver)
  @updates_needed.click_edit_update
end