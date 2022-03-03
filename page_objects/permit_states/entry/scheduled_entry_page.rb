# frozen_string_literal: true

require_relative '../../base_page'

# ScheduledEntryPage object
class ScheduledEntryPage < BasePage
  SCHEDULED_ENTRY = {
    page_header: "//*[@id='root']/div/nav[1]/header/h1",
    view_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'View')]"
  }.freeze

  def initialize(driver)
    super
    find_element(SCHEDULED_ENTRY[:page_header])
  end

  def click_view_btn(permit_id)
    permit_xpath = SCHEDULED_ENTRY[:view_terminate_btn] % permit_id
    click(permit_xpath)
  end
end
