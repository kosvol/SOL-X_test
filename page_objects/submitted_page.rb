# frozen_string_literal: true

# require_relative '../service/utils/user_service'
require_relative 'base_page'

# SubmittedPage object
class SubmittedPage < BasePage
  SUBMITTED = {
    submitted_header: "//h3[contains(.,'Successfully Submitted')]",
    home_btn: "//button[contains(.,'Back to Home')]"
  }.freeze

  def click_home_button
    click(SUBMITTED[:home_btn])
  end

  def verify_header_text
    find_element(SUBMITTED[:submitted_header])
  end
end
