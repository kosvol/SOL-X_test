# frozen_string_literal: true

require_relative '../../base_page'

# PendingApprovalEntryPage object
class PendingApprovalEntryPage < BasePage
  PENDING_APPROVAL_ENTRY = {
    page_header: "//*[@id='root']/div/nav[1]/header/h1",
    request_update_btn: "//button[contains(.,'Request Updates')]",
    update_comment_box: "//textarea[@id='updatesNeededComment']",
    submit_update_btn: "//button[contains(.,'Submit')]",
    submit_for_approval_btn: "//*[contains(.,'Submit for Approval')]",
    update_btn: "//button[contains(.,'Updates Needed')]",
    close_btn: "//button[contains(.,'Close')]",
    approve_for_activation: "//button[contains(.,'Approve for Activation')]"
  }.freeze


  def initialize(driver)
    super
    find_element(PENDING_APPROVAL_ENTRY[:page_header])
  end

  def request_for_update
    click(PENDING_APPROVAL_ENTRY[:request_for_update])
    enter_text(PENDING_APPROVAL_ENTRY[:update_comment_box], 'Test Automation')
    find_elements(PENDING_APPROVAL_ENTRY[:submit_update_btn]).last.click
  end

  def verify_buttons_not_ro
    verify_element_not_exist(PENDING_APPROVAL_ENTRY[:submit_for_approval_btn])
    verify_element_not_exist(PENDING_APPROVAL_ENTRY[:update_btn])
    raise 'Close button is disabled' unless find_element(PENDING_APPROVAL_ENTRY[:close_btn]).enabled?
  end

  def approve_for_activation
    click(PENDING_APPROVAL_ENTRY[:approve_for_activation])
  end

end