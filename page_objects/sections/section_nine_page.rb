# frozen_string_literal: true

require_relative '../base_page'

# SectionNinePage object
class SectionNinePage < BasePage
  include EnvUtils
  SECTION_NINE = {
    section_header: "//h3[contains(.,'Section 9: Withdrawal of Permit')]",
    withdraw_ptw_btn: "//button[contains(., 'Withdraw Permit To Work')]",
    request_update_btn: "//button[contains(., 'Request Updates')]"
  }.freeze

  def initialize(driver)
    super
    find_element(SECTION_NINE[:section_header])
  end

  def verify_withdraw_btn(option)
    verify_btn_availability(SECTION_NINE[:withdraw_ptw_btn], option)
  end

  def verify_signature_is_hidden
    verify_element_not_exist("//*[span='Permit Withdrawn By:']")
    verify_element_not_exist(SECTION_NINE[:withdraw_ptw_btn])
    verify_element_not_exist(SECTION_NINE[:request_update_btn])
  end

  def verify_request_update_btn(option)
    verify_btn_availability(SECTION_NINE[:request_update_btn], option)
  end
end
