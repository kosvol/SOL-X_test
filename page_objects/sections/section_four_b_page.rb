# frozen_string_literal: true

require_relative '../base_page'

# SectionFourBPage object
class SectionFourBPage < BasePage
  include EnvUtils
  SECTION_FOUR_B = {
    section_header: "//h3[contains(.,'Section 4B: Energy Isolation Certificate')]",
    eic_answer_yes_btn: '//*[@name="energyIsolationCertIssued" and @value="yes"]',
    create_eic_btn: "//button[contains(.,'Create Energy Isolation Certificate')]",
    sign_btn: "//button[contains(.,'Sign')]",
    location_stamp: "(//*[starts-with(@class,'AnswerComponent__Answer')])[last()]",
    rank_name: "(//*[starts-with(@class,'Cell__Description')])[1]"
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

  def verify_location_stamp(zone)
    actual_element = find_element(SECTION_FOUR_B[:location_stamp])
    wait_util_text_update(actual_element, 'Not Answered') # wait for location update
    compare_string(zone, actual_element.text)
  end

  def verify_rank_name(rank)
    expected_rank_name = UserService.new.retrieve_rank_and_name(rank)
    actual_element = find_element(SECTION_FOUR_B[:rank_name])
    wait_util_text_update(actual_element, 'Not Answered') # wait for location update
    compare_string(expected_rank_name, actual_element.text)
  end

  private

  def wait_util_text_update(element, text_to_update)
    wait = 0
    until element.text != text_to_update
      sleep 0.5
      wait += 1
      break if wait > 5
    end
  end
end
