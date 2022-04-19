# frozen_string_literal: true

require_relative '../base_permit_states_page'

# CreatedPTWPage object
class CreatedPTWPage < BasePermitStatesPage
  include EnvUtils
  CREATED_PTW = {
    page_header: "//h1[contains(.,'Created Permits to Work')]",
    first_edit_btn: "(//button[contains(., 'Edit')])[1]",
    edit_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'Edit')]"
  }.freeze

  def initialize(driver)
    super
    find_element(CREATED_PTW[:page_header])
  end

  def click_first_permit
    click(CREATED_PTW[:first_edit_btn])
  end

  def click_edit_btn(permit_id)
    permit_xpath = CREATED_PTW[:edit_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end
end
