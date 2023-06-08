# frozen_string_literal: true

require_relative '../../../../../page_objects/permit_states/entry/pending_approval_entry_page'

And('PendingApprovalEntry click Officer Approval') do
  @pending_approval_entry_page ||= PendingApprovalEntryPage.new(@driver)
  @pending_approval_entry_page.click_officer_approval(@permit_id)
end

And('PendingApprovalEntry click delete') do
  @pending_approval_entry_page ||= PendingApprovalEntryPage.new(@driver)
  @pending_approval_entry_page.delete_first_permit(@permit_id)
end

Then('PendingApprovalEntry verify deleted permit not presents in list') do
  @pending_approval_entry_page.verify_deleted_permit(@permit_id)
end
