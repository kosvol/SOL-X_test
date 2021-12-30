# frozen_string_literal: true

require_relative 'base_page'

# Entry display page object
class EntryDisplay < BasePage

  ENTRY_DISPLAY = {
    page_header: "//*[@id='root']/div/nav/header"
  }.freeze

  def initialize(driver)
    super
    find_element(ENTRY_DISPLAY[:page_header])
  end

  def wait_for_permit_active
    attempt = 0
    until return_background_color == 'rgba(67, 160, 71, 1)'
      attempt += 1
      raise 'timeout for waiting active ptw' if attempt == 6
    end
  end

end