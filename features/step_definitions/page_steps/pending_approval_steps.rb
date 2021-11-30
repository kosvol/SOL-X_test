# frozen_string_literal: true

require_relative '../../../page_objects/pending_approval_page'


Then('PendingApproval click Officer Approval button') do
  @pending_approval_page ||= PendingApprovalPage.new(@driver)
  @pending_approval_page.click_officer_approval_btn
end
