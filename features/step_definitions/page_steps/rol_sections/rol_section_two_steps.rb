# frozen_string_literal: true

require_relative '../../../../page_objects/rol_sections/rol_section_two_page'

Then('RoLSectionTwo verify checklist details') do
  @rol_section_two_page ||= RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.verify_rol_checklist_details
end

Then('RoLSectionTwo verify section 2 data') do
  @rol_section_two_page ||= RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.verify_rol_section_two_data
end

Then('RoLSectionTwo verify checklist warning box') do
  @rol_section_two_page ||= RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.verify_checklist_warn_box
end

Then('RoLSectionTwo verify dropdown for Description of boarding arrangement') do |table|
  @rol_section_two_page ||= RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.verify_ddl_value(table)
end
