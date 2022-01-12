# frozen_string_literal: true

require_relative '../../base_page'

# ActiveEntryPage object
class ActiveEntryPage < BasePage
  include EnvUtils
  ACTIVE_ENTRY = {
    page_header: "//*[@id='root']/div/nav[1]/header/h1",
    terminate_btn: "//button[contains(.,'Terminate')]",
    view_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'View')]"
  }.freeze

  def initialize(driver)
    super
    find_element(ACTIVE_ENTRY[:page_header])
  end

  def terminate_permit(permit_id)
    click("//span[contains(text(),'#{permit_id}')]//following::span[contains(text(),'Submit for Termination')][1]")
  end

  def click_terminate_button
    click(ACTIVE_ENTRY[:terminate_btn])
  end

  def click_view_btn(permit_id)
    permit_xpath = ACTIVE_ENTRY[:view_terminate_btn] % permit_id
    click(permit_xpath)
  end
end
