# frozen_string_literal: true

require_relative '../../../../page_objects/rol_sections/rol_section_three_page'

Given('RoLSectionThree verify task commenced time') do
  @rol_section_three_page = RoLSectionThreePage.new(@driver)
  @rol_section_three_page.verify_commenced_time(@active_ptw_page.issued_time)
end

Then('RoLSectionThree verify section 3 data') do
  @rol_section_three_page = RoLSectionThreePage.new(@driver)
  @rol_section_three_page.verify_rol_section_three_data
end

And('RoLSectionThree should not see extra Previous and Close buttons') do
  @rol_section_three_page ||= RoLSectionThreePage.new(@driver)
  @rol_section_three_page.verify_no_extra_btns
end
