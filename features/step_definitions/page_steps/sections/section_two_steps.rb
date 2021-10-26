# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_two_page'

Given('Section2 should see section header') do
  @section_two_page ||= SectionTwoPage.new(@driver)
  @section_two_page.verify_section_header
end
