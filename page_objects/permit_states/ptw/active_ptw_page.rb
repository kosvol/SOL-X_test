# frozen_string_literal: true

require_relative '../base_permit_states_page'

# ActivePTWPage object
class ActivePTWPage < BasePermitStatesPage
  include EnvUtils
  ACTIVE_PTW = {
    page_header: "//h1[contains(.,'Active Permits to Work')]",
    view_terminate_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'View / Terminate')]"
  }.freeze

  def initialize(driver)
    super
    find_element(ACTIVE_PTW[:page_header])
  end

  def click_view_terminate_btn(permit_id)
    permit_xpath = ACTIVE_PTW[:view_terminate_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end
end
