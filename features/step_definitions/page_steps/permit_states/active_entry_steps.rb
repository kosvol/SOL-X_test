# frozen_string_literal: true
require_relative '../../../../page_objects/permit_states/active_entry_page'

And('ActiveEntry click Submit for termination') do
  @active_entry_page ||= ActiveEntryPage.new(@driver)
  @active_entry_page.terminate_permit(CreateEntryPermitPage.permit_id)
end

And('ActiveEntry click Terminate button') do
  @active_entry_page ||= ActiveEntryPage.new(@driver)
  @active_entry_page.click_terminate_button
end

And('ActiveEntry open current permit for view') do
  @active_entry_page ||= ActiveEntryPage.new(@driver)
  @active_entry_page.click_view_btn(CreateEntryPermitPage.permit_id)
end
