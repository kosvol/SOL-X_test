# frozen_string_literal: true

require_relative '../base_permit_states_page'

# PendingApprovalEntryPage object
class PendingApprovalEntryPage < BasePermitStatesPage
  PENDING_APPROVAL_ENTRY = {
    page_header: "//h1[contains(.,'Pending Approval')]",
    officer_approval_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'Officer Approval')]",
    first_delete_btn: "(//button[contains(.,'Delete')])[1]"
  }.freeze

  def initialize(driver)
    super
    find_element(PENDING_APPROVAL_ENTRY[:page_header])
  end

  def click_officer_approval(permit_id)
    permit_xpath = PENDING_APPROVAL_ENTRY[:officer_approval_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end

  def delete_first_permit(permit_id)
    permit_xpath = PENDING_APPROVAL_ENTRY[:first_delete_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end

  def verify_deleted_permit(permit_id)
    verify_element_not_exist("//span[text()='#{permit_id}']")
  end
end
