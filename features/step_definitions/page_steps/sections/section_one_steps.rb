# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_one_page'

Given('Section1 should see section header') do
  @section_one_page ||= SectionOnePage.new(@driver)
end

Given('Section1 verify permit details') do
  @section_one_page ||= SectionOnePage.new(@driver)
  @section_one_page.verify_permit_details(@level1_permit)
end

Given('Section1 verify dropdown for {string}') do |ddl_type, table|
  @section_one_page ||= SectionOnePage.new(@driver)
  @section_one_page.verify_ddl_value(ddl_type, table)
end

Then('Section1 should see not see previous button') do
  @section_one_page ||= SectionOnePage.new(@driver)
  @section_one_page.verify_no_previous_btn
end

Then('Section1 {string} see duration of maintenance dropdown') do |option|
  @section_one_page ||= SectionOnePage.new(@driver)
  @section_one_page.verify_duration_ddl(option)
end

Then('Section1 click Save & Next') do
  @section_one_page ||= SectionOnePage.new(@driver)
  @section_one_page.click_save_next
end

Given('Section1 answer duration of maintenance over 2 hours as {string}') do |option|
  @section_one_page ||= SectionOnePage.new(@driver)
  @section_one_page.answer_duration_maintenance(option)
end
