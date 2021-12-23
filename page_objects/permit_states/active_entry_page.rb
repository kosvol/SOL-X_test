# frozen_string_literal: true

require_relative '../base_page'

# ActiveEntryPage object
class ActiveEntryPage < BasePage
  include EnvUtils
  ACTIVE_PTW = {
    page_header: "//h1[contains(.,'Active Permits to Work')]",
    terminate_btn: "//button[contains(.,'Terminate')]",
    view_btn: "//button[contains(.,'View')]"
  }.freeze

  def initialize(driver)
    super
    find_element(ACTIVE_PTW[:page_header])
  end

  def terminate_permit(permit_id)
    click("//span[contains(text(),'#{permit_id}')]//following::span[contains(text(),'Submit for Termination')][1]")
  end

  def click_terminate_button
    click(ACTIVE_PTW[:terminate_btn])
  end

  def open_ptw_for_view
    permit_index = retrieve_permit_index(CreateEntryPermitPage.permit_id)
    find_elements(ACTIVE_PTW[:view_btn])[permit_index].click
  end

end