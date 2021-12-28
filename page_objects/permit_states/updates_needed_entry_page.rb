# frozen_string_literal: true

require_relative '../base_page'

# UpdatesNeededEntryPage object
class UpdatesNeededEntryPage < BasePage
  include EnvUtils
  UPDATES_NEEDED_ENTRY = {
    page_header: "//*[@id='root']/div/nav[1]/header/h1",
    edit_update_btn: "//button[contains(.,'Edit/Update')]"
  }.freeze

  def initialize(driver)
    super
    find_element(UPDATES_NEEDED_ENTRY[:page_header])
  end

  def click_edit_update
    click(UPDATES_NEEDED_ENTRY[:edit_update_btn])
  end
end
