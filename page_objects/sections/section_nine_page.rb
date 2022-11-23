# frozen_string_literal: true

require_relative '../base_page'

# SectionNinePage object
class SectionNinePage < BasePage
  include EnvUtils
  SECTION_NINE = {
    section_header: "//h3[contains(.,'Section 9: Withdrawal of Permit')]",
    withdraw_ptw_btn: "//button[contains(., 'Withdraw Permit To Work')]",
    request_update_btn: "//button[contains(., 'Request Updates')]",
    submit_btn: "//button[contains(., 'Submit')]",
    aa_comments: '//textarea[@id="updatesNeededComment"]'
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

  def click_withdraw
    click(SECTION_NINE[:withdraw_ptw_btn])
  end

  def click_request_updates_btn
    sleep 1
    scroll_click(SECTION_NINE[:request_update_btn])
  end

  def enter_aa_comments(text)
    element = find_element(SECTION_NINE[:aa_comments])
    @driver.execute_script('arguments[0].scrollIntoView({block: "center", inline: "center"})', element)
    element.send_keys(text)
  end

  def click_submit_btn
    sleep 1
    scroll_click(SECTION_NINE[:submit_btn])
  end
end
