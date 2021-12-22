# frozen_string_literal: true

require_relative '../base_page'

# ActivePTWPage object
class ActivePTWPage < BasePage
  include EnvUtils
  ACTIVE_PTW = {
    page_header: "//h1[contains(.,'Active Permits to Work')]",
    terminate_btn: "//button[contains(.,'Terminate')]",
  }.freeze

  def initialize(driver)
    super
    find_element(ACTIVE_PTW[:page_header])
  end

  def terminate_permit
    click("//span[contains(text(),'#{CreateEntryPermitPage.permit_id}')]//following::span[contains(text(),'Submit for Termination')][1]")
  end

  def click_terminate_button
    click(ACTIVE_PTW[:terminate_btn])
  end

end