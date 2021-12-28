# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_eight_page'

Given('Section8 verify termination button is {string}') do |option|
  @section_eight_page = SectionEightPage.new(@driver)
  @section_eight_page.verify_termination_btn(option)
end

Given('Section8 verify RA signature section is hidden') do
  @section_eight_page = SectionEightPage.new(@driver)
  @section_eight_page.verify_ra_signature_is_hidden
end
