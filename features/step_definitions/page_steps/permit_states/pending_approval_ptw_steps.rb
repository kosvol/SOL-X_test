# frozen_string_literal: true

require_relative '../../../../page_objects/permit_states/pending_approval_ptw_page'

And('PendingApprovalPTW click approval button') do
  @pending_approval_ptw_page ||= PendingApprovalPTWPage.new(@driver)
  @pending_approval_ptw_page.click_approval_btn(@permit_id)
end
