# frozen_string_literal: true

require_relative '../base_page'

# SectionTwoPage object
class SectionTwoPage < BasePage
  SECTION_TWO = {
    section_header: "//h3[contains(.,'Section 2: Approving Authority')]",
    next_btn: "//button[contains(.,'Next')]",
    previous_btn: "//button[contains(.,'Previous')]",
    form_answers: "//*[starts-with(@class,'AnswerComponent__Answer')]"
  }.freeze

  def initialize(driver)
    super
    find_element(SECTION_TWO[:section_header])
  end

  def verify_previous_and_next
    find_element(SECTION_TWO[:previous_btn])
    find_element(SECTION_TWO[:next_btn])
  end

  def verify_approving_authority(expected)
    answers = @driver.find_elements(:xpath, SECTION_TWO[:form_answers])
    actual_ship_approval = answers[0].text
    actual_office_approval = answers[1].text
    compare_string(expected['ship_approval'], actual_ship_approval)
    compare_string(expected['office_approval'], actual_office_approval)
  end
end
