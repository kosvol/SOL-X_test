# frozen_string_literal: true

require_relative '../base_page'

# SectionTwoPage object
class SectionTwoPage < BasePage
  SECTION_TWO = {
    section_header: "//h3[contains(.,'Section 2: Approving Authority')]",
    next_btn: "//button[contains(.,'Next')]",
    previous_btn: "//button[contains(.,'Previous')]",
    ship_approval_answer: "(//*[starts-with(@class,'AnswerComponent__Answer')])[1]",
    office_approval_answer: "(//*[starts-with(@class,'AnswerComponent__Answer')])[2]"
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
    sleep 0.5 # wait for the element updated
    actual_ship_approval = retrieve_text(SECTION_TWO[:ship_approval_answer])
    actual_office_approval = retrieve_text(SECTION_TWO[:office_approval_answer])
    compare_string(expected['ship_approval'], actual_ship_approval)
    compare_string(expected['office_approval'], actual_office_approval)
  end
end
