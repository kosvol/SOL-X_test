# frozen_string_literal: true

require_relative '../base_page'

# CreatedPTWPage object
class CreatedPTWPage < BasePage
  include EnvUtils
  CREATED_PTW = {
    page_header: "//h1[contains(.,'Created Permits to Work')]",
    first_edit_btn: "(//button[contains(., 'Edit')])[1]"
  }.freeze

  def initialize(driver)
    super
    find_element(CREATED_PTW[:page_header])
  end

  def click_first_permit
    click(CREATED_PTW[:first_edit_btn])
  end
end
