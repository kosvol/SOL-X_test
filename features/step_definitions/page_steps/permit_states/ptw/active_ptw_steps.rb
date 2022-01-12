# frozen_string_literal: true

require_relative '../../../../../page_objects/permit_states/ptw/active_ptw_page'

And(%r{ActivePTW click View/Terminate button}) do
  @active_ptw ||= ActivePTWPage.new(@driver)
  @active_ptw.click_view_terminate_btn(@permit_id)
end
