# frozen_string_literal: true

require_relative '../../../../../page_objects/permit_states/entry/scheduled_entry_page'

And('ScheduledEntry open current permit for view') do
  @scheduled_entry_page ||= ScheduledEntryPage.new(@driver)
  @scheduled_entry_page.click_view_btn(CreateEntryPermitPage.permit_id)
end
