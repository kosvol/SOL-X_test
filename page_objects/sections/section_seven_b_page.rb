# frozen_string_literal: true

require_relative '../base_page'

# SectionSevenBPage object
class SectionSevenBPage < BasePage
  include EnvUtils
  SECTION_SEVEN_B = {
    section_header: "//h3[contains(.,'Section 7B: Validity of Permit')]",
    permit_issued_on: "(//*[starts-with(@class,'AnswerComponent__Answer')])[1]",
    permit_valid_until: "(//*[starts-with(@class,'AnswerComponent__Answer')])[2]"
  }.freeze


  def initialize(driver)
    super
    find_element(SECTION_SEVEN_B[:section_header])
  end

  def verify_permit_time(expected_time)
    actual_permit_issued = retrieve_text(SECTION_SEVEN_B[:permit_issued_on])
    compare_string(expected_time, actual_permit_issued)
    actual_valid_until = retrieve_text(SECTION_SEVEN_B[:permit_valid_until])
    expected_valid_time = (Time.parse(expected_time) + ((60 * 60) * 8)).strftime('%d/%b/%Y %H:%M')
    raise 'valid time verify failed' unless actual_valid_until.include? expected_valid_time.to_s
  end
end
