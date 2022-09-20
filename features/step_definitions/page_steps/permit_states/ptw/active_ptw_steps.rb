# frozen_string_literal: true

require_relative '../../../../../page_objects/permit_states/ptw/active_ptw_page'

And(%r{ActivePTW click View/Terminate button}) do
  @active_ptw_page ||= ActivePTWPage.new(@driver)
  @active_ptw_page.click_view_terminate_btn(@permit_id)
end

And('ActivePTW save time info') do
  @active_ptw_page ||= ActivePTWPage.new(@driver)
  @active_ptw_page.save_time_info(@permit_id)
end

And('ActivePTW click New Entrant button') do
  @active_ptw_page ||= ActivePTWPage.new(@driver)
  @active_ptw_page.click_new_entrant_btn(@permit_id)
end

And('ActivePTW click Gas Test button') do
  @active_ptw_page ||= ActivePTWPage.new(@driver)
  @active_ptw_page.click_gas_test_btn(@permit_id)
end

And('ActivePTW verify issued date') do
  @active_ptw_page ||= ActivePTWPage.new(@driver)
  @active_ptw_page.verify_issued_date(@permit_id)
end

And('ActivePTW verify time left less than {string}') do |time|
  @active_ptw_page ||= ActivePTWPage.new(@driver)
  @active_ptw_page.verify_time_left(@permit_id, time)
end

Then('ActivePTW should see view and termination buttons') do
  @active_ptw_page ||= ActivePTWPage.new(@driver)
  @active_ptw_page.verify_view_termination_btns(@permit_id)
end
