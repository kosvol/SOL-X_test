# frozen_string_literal: true

require_relative '../../../../../page_objects/permit_states/ptw/pending_withdrawal_ptw_page'

And('PendingWithdrawalPTW click Review & Withdraw button') do
  @pending_withdrawal_ptw_page ||= PendingWithdrawalPTWPage.new(@driver)
  @pending_withdrawal_ptw_page.click_review_withdraw_btn(@permit_id)
end

And('PendingWithdrawalPTW verify task status is {string}') do |task_status|
  @pending_withdrawal_ptw_page ||= PendingWithdrawalPTWPage.new(@driver)
  @pending_withdrawal_ptw_page.verify_task_status(@permit_id, task_status)
end
