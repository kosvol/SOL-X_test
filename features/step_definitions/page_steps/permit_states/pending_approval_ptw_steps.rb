# frozen_string_literal: true

require_relative '../../../../page_objects/permit_states/pending_approval_ptw_page'

And('PendingApprovalPTW click approval button') do
  @pending_approval_ptw_page ||= PendingApprovalPTWPage.new(@driver)
  @pending_approval_ptw_page.click_approval_btn(@permit_id)
end

And('PendingApprovalPTW request for update') do
  @pending_approval_ptw_page ||= PendingApprovalPTWPage.new(@driver)
  @pending_approval_ptw_page.request_for_update
end

And('PendingApprovalPTW verify buttons for not Pump Room Entry RO rank') do
  @pending_approval_ptw_page ||= PendingApprovalPTWPage.new(@driver)
  @pending_approval_ptw_page.verify_buttons_not_ro
end

And('PendingApprovalPTW click approve for activation') do
  @pending_approval_ptw_page ||= PendingApprovalPTWPage.new(@driver)
  @pending_approval_ptw_page.approve_for_activation
end