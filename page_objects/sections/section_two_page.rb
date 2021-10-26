# frozen_string_literal: true

require_relative '../base_page'

# SectionTwoPage object
class SectionTwoPage < BasePage
  include EnvUtils
  SECTION_TWO = {
    section_header: "//h3[contains(.,'Section 2: Approving Authority')]"
  }.freeze

  def verify_section_header
    find_element(SECTION_TWO[:section_header])
  end
end
