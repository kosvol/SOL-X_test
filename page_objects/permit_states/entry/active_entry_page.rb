# frozen_string_literal: true

require_relative '../base_permit_states_page'

# ActiveEntryPage object
class ActiveEntryPage < BasePermitStatesPage
  include EnvUtils
  ACTIVE_ENTRY = {
    page_header: "//*[@id='root']/div/nav[1]/header/h1",
    view_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'View')]",
    submit_for_terminate_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'Submit for Termination')]"
  }.freeze

  def initialize(driver)
    super
    find_element(ACTIVE_ENTRY[:page_header])
  end

  def click_view_btn(permit_id)
    click(ACTIVE_ENTRY[:view_terminate_btn] % permit_id)
  end

  def click_submit_for_terminate(permit_id)
    permit_xpath = ACTIVE_ENTRY[:submit_for_terminate_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end
end
