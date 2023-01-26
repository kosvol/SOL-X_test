# frozen_string_literal: true

require_relative '../base_page'
require_relative '../../service/utils/user_service'

# SectionThreeDPage object
class SectionThreeDPage < BasePage
  include EnvUtils
  SECTION_THREE_D = {
    section_header: "//h3[contains(.,'Section 3D: DRA - Summary & Assessment')]",
    location_stamp: "(//*[starts-with(@class,'AnswerComponent__Answer')])[last()]",
    rank_name: "(//div[starts-with(@class, 'Cell__Description')])[1]",
    sign_btn: "//button[contains(., 'Enter PIN & Sign')]"
  }.freeze

  def initialize(driver)
    super
    find_element(SECTION_THREE_D[:section_header])
  end

  def verify_location_stamp(zone)
    actual_element = find_element(SECTION_THREE_D[:location_stamp])
    wait_until_text_update(actual_element, 'Not Answered') # wait for location update
    compare_string(zone, actual_element.text)
  end

  def verify_rank(rank)
    expected_rank_name = UserService.new.retrieve_rank_and_name(rank)
    actual_element = find_element(SECTION_THREE_D[:rank_name])
    wait_until_text_update(actual_element, 'Not Answered') # wait for location update
    compare_string(expected_rank_name, actual_element.text)
  end

  def verify_sign_button(option)
    verify_btn_availability(SECTION_THREE_D[:sign_btn], option)
  end
end