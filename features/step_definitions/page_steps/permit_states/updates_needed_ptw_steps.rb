# frozen_string_literal: true

require_relative '../../../../page_objects/permit_states/updates_needed_ptw_page'

And('UpdatesNeededPTW click Edit/Update button') do
  @update_needed_ptw ||= UpdateNeededPTWPage.new(@driver)
  @update_needed_ptw.click_edit_update_btn(@permit_id)
end
