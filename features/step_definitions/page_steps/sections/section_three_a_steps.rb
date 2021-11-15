# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_three_a_page'

Given('Section3A verify answers') do
  @section_three_a_page ||= SectionThreeAPage.new(@driver)
  @section_three_a_page.verify_section3_answers
end

Given('Section3A click edit hazards') do
  @section_three_a_page ||= SectionThreeAPage.new(@driver)
  @section_three_a_page.click_edit_hazards
end
