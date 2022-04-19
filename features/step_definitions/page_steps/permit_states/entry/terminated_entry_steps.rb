# frozen_string_literal: true

require_relative '../../../../../page_objects/permit_states/entry/terminated_entry_page'

And('TerminatedEntry click View') do
  @terminated_entry_page ||= TerminatedEntryPage.new(@driver)
  @terminated_entry_page.click_view_btn(@permit_id)
end
