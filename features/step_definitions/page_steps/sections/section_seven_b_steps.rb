# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_seven_b_page'

Given('Section7B verify validity date and time') do
  @section_seven_b_page = SectionSevenBPage.new(@driver)
  @section_seven_b_page.verify_permit_time(@active_ptw_page.issued_time)
end
