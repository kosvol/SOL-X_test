# frozen_string_literal: true

require_relative '../base_permit_states_page'

# PendingWithdrawalPTWPage object
class PendingWithdrawalPTWPage < BasePermitStatesPage
  include EnvUtils
  PENDING_WITHDRAWAL_PTW = {
    page_header: "//h1[contains(.,'Pending Withdrawal Permits to Work')]",
    review_withdraw_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'Review & Withdraw')]",
    task_status: "(//*[span='%s']/*[@class='note-row-wrapper']/*/*/*)[6]"
  }.freeze

  def initialize(driver)
    super
    find_element(PENDING_WITHDRAWAL_PTW[:page_header])
  end

  def click_review_withdraw_btn(permit_id)
    permit_xpath = PENDING_WITHDRAWAL_PTW[:review_withdraw_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end

  def verify_task_status(permit_id, task_status)
    actual_status = retrieve_text(PENDING_WITHDRAWAL_PTW[:task_status] % permit_id)
    compare_string(task_status, actual_status)
  end
end
