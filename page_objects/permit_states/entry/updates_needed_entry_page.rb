# frozen_string_literal: true

require_relative '../base_permit_states_page'

# UpdatesNeededEntryPage object
class UpdatesNeededEntryPage < BasePermitStatesPage
  include EnvUtils
  UPDATES_NEEDED_ENTRY = {
    page_header: "//h1[contains(.,'Updates Needed')]",
    edit_update_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'Edit/Update')]"
  }.freeze

  def initialize(driver)
    super
    find_element(UPDATES_NEEDED_ENTRY[:page_header])
  end

  def click_edit_update(permit_id)
    permit_xpath = UPDATES_NEEDED_ENTRY[:edit_update_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end
end
