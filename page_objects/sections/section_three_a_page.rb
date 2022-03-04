# frozen_string_literal: true

require_relative '../base_page'

# SectionThreeAPage object
class SectionThreeAPage < BasePage
  include EnvUtils
  SECTION_THREE_A = {
    section_header: "//h3[contains(.,'Section 3A: DRA - Method & Hazards')]",
    form_answers: "//*[starts-with(@class,'AnswerComponent__Answer')]",
    edit_hazard_btn: "//button[contains(.,'View/Edit Hazards')]"
  }.freeze

  def initialize(driver)
    super
    find_element(SECTION_THREE_A[:section_header])
  end

  def verify_section3_answers
    answers = @driver.find_elements(:xpath, SECTION_THREE_A[:form_answers])
    actual_vessel_name = answers[0].text
    actual_dra_no = answers[1].text
    compare_string(retrieve_vessel_name, actual_vessel_name)
    raise 'DRA no is not updated' if actual_dra_no.include? 'DRA/TEMP'
  end

  def click_edit_hazards
    scroll_click(SECTION_THREE_A[:edit_hazard_btn])
    sleep 0.5
  end
end
