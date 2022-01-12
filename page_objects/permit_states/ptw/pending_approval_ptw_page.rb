# frozen_string_literal: true

require_relative '../base_permit_states_page'

# PendingApprovalPTWPage object
class PendingApprovalPTWPage < BasePermitStatesPage
  include EnvUtils
  PENDING_APPROVAL_PTW = {
    page_header: "//h1[contains(.,'Pending Approval Permits to Work')]",
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

end
