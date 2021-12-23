# frozen_string_literal: true

require_relative '../base_page'

# PendingApprovalPTWPage object
class UpdatesNeededEntryPage < BasePage
  include EnvUtils
  UPDATES_NEEDED_PTW = {
    page_header: "//h1[contains(.,'Updates Needed Permits to Work')]",
    edit_update_btn: "//button[contains(.,'Edit/Update')]",
  }.freeze

  def initialize(driver)
    super
    find_element(UPDATES_NEEDED_PTW[:page_header])
  end

  def click_edit_update
    click(UPDATES_NEEDED_PTW[:edit_update_btn])
  end
end