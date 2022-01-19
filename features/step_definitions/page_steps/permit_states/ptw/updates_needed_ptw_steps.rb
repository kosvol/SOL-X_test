# frozen_string_literal: true

require_relative '../../../../../page_objects/permit_states/ptw/updates_needed_ptw_page'

And(%r{UpdatesNeededPTW click Edit/Update button}) do
  @update_needed_ptw_page ||= UpdateNeededPTWPage.new(@driver)
  @update_needed_ptw_page.click_edit_update_btn(@permit_id)
end
