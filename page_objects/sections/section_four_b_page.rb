# frozen_string_literal: true

require_relative '../base_page'

# SectionFourBPage object
class SectionFourBPage < BasePage
  include EnvUtils
  SECTION_FOUR_B = {
    section_header: "//h3[contains(.,'Section 4B: Energy Isolation Certificate')]",
    eic_answer_yes_btn: '//*[@name="energyIsolationCertIssued" and @value="yes"]',
    create_eic_btn: "//button[contains(.,'Create Energy Isolation Certificate')]",
    sign_btn: "//button[contains(.,'Sign')]"
  }.freeze

  def initialize(driver)
    super
    find_element(SECTION_FOUR_B[:section_header])
  end

  def select_yes_for_eic
    @driver.find_element(:xpath, SECTION_FOUR_B[:eic_answer_yes_btn]).click
  end

  def click_create_eic
    @driver.find_element(:xpath, SECTION_FOUR_B[:create_eic_btn]).click
  end

  def click_sign_btn
    click(SECTION_FOUR_B[:sign_btn])
  end
end
