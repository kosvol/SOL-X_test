# frozen_string_literal: true
require_relative '../../../../page_objects/permit_states/active_entry_page'

And('ActiveEntry click Submit for termination') do
  @activate_page ||= ActiveEntryPage.new(@driver)
  @activate_page.terminate_permit(CreateEntryPermitPage.permit_id)
end

And('ActiveEntry click Terminate button') do
  @activate_page ||= ActiveEntryPage.new(@driver)
  @activate_page.click_terminate_button
end

And('ActiveEntry open current permit for view') do
  @activate_page ||= ActiveEntryPage.new(@driver)
  @activate_page.open_ptw_for_view
end
