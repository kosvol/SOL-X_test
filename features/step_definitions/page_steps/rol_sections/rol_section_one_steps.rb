# frozen_string_literal: true

require_relative '../../../../page_objects/rol_sections/rol_section_one_page'

Then('RoLSectionOne verify DRA details') do
  @rol_section_one_page ||= RoLSectionOnePage.new(@driver)
  @rol_section_one_page.verify_rol_dra_details
end

Then('RoLSectionOne verify section 1 data') do
  @rol_section_one_page ||= RoLSectionOnePage.new(@driver)
  @rol_section_one_page.verify_rol_section_one_data
end

Then('RoLSectionOne should not see previous button') do
  @rol_section_one_page ||= RoLSectionOnePage.new(@driver)
  @rol_section_one_page.verify_no_previous_btn
end

Given('RoLSectionOne verify next button is {string}') do |option|
  @rol_section_one_page ||= RoLSectionOnePage.new(@driver)
  @rol_section_one_page.verify_next_btn_text(option)
end
