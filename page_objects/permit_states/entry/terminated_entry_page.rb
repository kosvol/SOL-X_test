# frozen_string_literal: true

require_relative '../base_permit_states_page'

# TerminatedEntryPage object
class TerminatedEntryPage < BasePermitStatesPage
  TERMINATED_ENTRY = {
    page_header: "//*[@id='root']/div/nav[1]/header/h1",
    view_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'View')]"
  }.freeze

  def initialize(driver)
    super
    find_element(TERMINATED_ENTRY[:page_header])
  end

  def click_view_btn(permit_id)
    permit_xpath = TERMINATED_ENTRY[:view_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end
end
