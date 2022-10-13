# frozen_string_literal: true

require_relative '../../../../../page_objects/permit_states/ptw/pending_approval_ptw_page'

And('PendingApprovalPTW click Approval button') do
  @pending_approval_ptw_page ||= PendingApprovalPTWPage.new(@driver)
  @pending_approval_ptw_page.click_approval_btn(@permit_id)
end

And('PendingApprovalPTW delete first permit id') do
  @pending_approval_ptw_page ||= PendingApprovalPTWPage.new(@driver)
  @permit_id = @pending_approval_ptw_page.save_first_permit_id
  @pending_approval_ptw_page.delete_first_permit
end

And('PendingApprovalPTW verify deleted permit') do
  @pending_approval_ptw_page.verify_permit_is_deleted(@permit_id)
end