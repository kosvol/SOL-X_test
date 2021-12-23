# frozen_string_literal: true
require_relative '../../../../page_objects/permit_states/scheduled_entry_page'

And('ScheduledEntry open current permit for view') do
  @scheduled_entry_page ||= ScheduledEntryPage.new(@driver)
  @scheduled_entry_page.open_ptw_for_view
end
