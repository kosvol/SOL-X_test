# frozen_string_literal: true

require_relative '../../../../../page_objects/permit_states/entry/pending_approval_entry_page'

And('PendingApprovalEntry request for update') do
  @pending_approval_entry_page ||= PendingApprovalEntryPage.new(@driver)
  @pending_approval_entry_page.request_for_update
end

And('PendingApprovalEntry verify buttons for not Pump Room Entry RO rank') do
  @pending_approval_entry_page ||= PendingApprovalEntryPage.new(@driver)
  @pending_approval_entry_page.verify_buttons_not_ro
end

And('PendingApprovalEntry click approve for activation') do
  @pending_approval_entry_page ||= PendingApprovalEntryPage.new(@driver)
  @pending_approval_entry_page.approve_for_activation
end
