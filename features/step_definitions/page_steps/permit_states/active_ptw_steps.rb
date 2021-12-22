# frozen_string_literal: true
require_relative '../../../../page_objects/permit_states/active_ptw_page'

And('ActivatePage click Submit for termination') do
  @activate_page ||= ActivePTWPage.new(@driver)
  @activate_page.terminate_permit
end

And('ActivatePage click Terminate button') do
  @activate_page ||= ActivePTWPage.new(@driver)
  @activate_page.click_terminate_button
end
