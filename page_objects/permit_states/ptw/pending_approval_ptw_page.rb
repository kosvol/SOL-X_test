# frozen_string_literal: true

require_relative '../base_permit_states_page'

# PendingApprovalPTWPage object
class PendingApprovalPTWPage < BasePermitStatesPage
  include EnvUtils
  PENDING_APPROVAL_PTW = {
    page_header: "//h1[contains(.,'Pending Approval Permits to Work')]",
    first_delete_btn: "(//button[contains(., 'Delete')])[1]",
    first_permit_id: "(//*[starts-with(@class,'Text__TextSmall')])[1]",
    approval_btn: "//*[span='%s']/*[@class='note-row']/button"
  }.freeze

  def initialize(driver)
    super
    find_element(PENDING_APPROVAL_PTW[:page_header])
  end

  def click_approval_btn(permit_id)
    permit_xpath = PENDING_APPROVAL_PTW[:approval_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end

  def delete_first_permit
    click(PENDING_APPROVAL_PTW[:first_delete_btn])
  end

  def save_first_permit_id
    retrieve_text(PENDING_APPROVAL_PTW[:first_permit_id])
  end

  def verify_permit_is_deleted(permit_id)
    verify_element_not_exist("//span[text()='#{permit_id}']")
  end

end
