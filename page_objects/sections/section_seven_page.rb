# frozen_string_literal: true

require_relative '../base_page'

# SectionSevenPage object
class SectionSevenPage < BasePage
  include EnvUtils
  SECTION_SEVEN = {
    section_header: "//h3[contains(.,'Section 7: Validity of Permit')]",
    active_btn: "//button[contains(., 'Activate Permit To Work')]",
    request_update_btn: "//button[contains(., 'Request Updates')]",
    permit_issued_on: "(//*[starts-with(@class,'AnswerComponent__Answer')])[1]",
    permit_valid_until: "(//*[starts-with(@class,'AnswerComponent__Answer')])[2]"
  }.freeze

  def initialize(driver)
    super
    find_element(SECTION_SEVEN[:section_header])
  end

  def verify_activate_btn(option)
    verify_btn_availability(SECTION_SEVEN[:active_btn], option)
  end

  def verify_request_update_btn(option)
    verify_btn_availability(SECTION_SEVEN[:request_update_btn], option)
  end
end
