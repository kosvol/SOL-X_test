# frozen_string_literal: true

require_relative '../base_page'

# SectionEightPage object
class SectionEightPage < BasePage
  include EnvUtils
  SECTION_EIGHT = {
    section_header: "//h3[contains(.,'Section 8: Task Status & EIC Normalisation')]",
    termination_btn: "//button[contains(., 'Submit For Termination')]"
  }.freeze


  def initialize(driver)
    super
    find_element(SECTION_EIGHT[:section_header])
  end

  def verify_termination_btn(option)
    verify_btn_availability(SECTION_EIGHT[:termination_btn], option)
  end

  def verify_ra_signature_is_hidden
    verify_element_not_exist(SECTION_EIGHT[:termination_btn])
    verify_element_not_exist("//*[span='Responsible Authority:']")
  end
end
