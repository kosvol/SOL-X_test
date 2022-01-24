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
