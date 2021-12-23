# frozen_string_literal: true
require_relative '../../../../page_objects/permit_states/terminated_entry_page'

And('TerminatedEntry open current permit for view') do
  @terminated_entry ||= TerminatedEntryPage.new(@driver)
  @terminated_entry.open_ptw_for_view
end
