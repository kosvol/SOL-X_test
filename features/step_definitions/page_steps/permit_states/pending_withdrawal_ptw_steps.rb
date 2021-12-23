# frozen_string_literal: true

require_relative '../../../../page_objects/permit_states/pending_withdrawal_ptw_page'

And('PendingWithdrawalPTW click Review & Withdraw button') do
  @pending_withdrawal_ptw_page ||= PendingWithdrawalPTWPage.new(@driver)
  @pending_withdrawal_ptw_page.click_review_withdraw_btn(@permit_id)
end
