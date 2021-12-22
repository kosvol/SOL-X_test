# frozen_string_literal: true

require_relative '../base_page'

# PendingApprovalPTWPage object
class PendingApprovalPTWPage < BasePage
  include EnvUtils
  PENDING_APPROVAL_PTW = {
    page_header: "//h1[contains(.,'Pending Approval Permits to Work')]",
    approval_btn: "//*[span='%s']/*[@class='note-row']/button",
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
    find_element(PENDING_APPROVAL_PTW[:page_header])
  end

  def click_approval_btn(permit_id)
    click(PENDING_APPROVAL_PTW[:approval_btn] % permit_id)
  end

  def request_for_update
    click(PENDING_APPROVAL_PTW[:request_for_update])
    enter_text(PENDING_APPROVAL_PTW[:update_comment_box], 'Test Automation')
    find_elements(PENDING_APPROVAL_PTW[:submit_update_btn]).last.click
  end

  def verify_buttons_not_ro
    verify_element_not_exist(PENDING_APPROVAL_PTW[:submit_for_approval_btn])
    verify_element_not_exist(PENDING_APPROVAL_PTW[:update_btn])
    raise 'Element disabled' unless find_element(PENDING_APPROVAL_PTW[:close_btn]).enabled?
  end

  def approve_for_activation
    click(PENDING_APPROVAL_PTW[:approve_for_activation])
  end

end
