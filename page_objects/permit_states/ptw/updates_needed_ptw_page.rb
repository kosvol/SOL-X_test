# frozen_string_literal: true

require_relative '../base_permit_states_page'

# UpdateNeededPTWPage object
class UpdateNeededPTWPage < BasePermitStatesPage
  include EnvUtils
  UPDATE_NEEDED_PTW = {
    page_header: "//h1[contains(.,'Updates Needed Permits to Work')]",
    edit_update_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'Edit/Update')]"
  }.freeze

  def initialize(driver)
    super
    find_element(UPDATE_NEEDED_PTW[:page_header])
  end

  def click_edit_update_btn(permit_id)
    permit_xpath = UPDATE_NEEDED_PTW[:edit_update_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end
end
