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

Then('RoLSectionTwo verify dropdown for {string}') do |ddl_type, table|
  @rol_section_two_page ||= RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.verify_ddl_value(ddl_type, table)
end

And('RoLSectionTwo should not see extra buttons') do
  @rol_section_two_page ||= RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.verify_no_extra_btns
end

Then('RoLSectionTwo verify submit button is {string}') do |option|
  @rol_section_two_page ||= RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.verify_submit_btn(option)
end

Then('RoLSectionTwo verify duration dropdown cannot be clicked') do
  @rol_section_two_page ||= RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.verify_no_duration_dd
end

And('RoLSectionTwo select the duration {int}') do |duration|
  @rol_section_two_page ||= RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.select_permit_duration(duration)
end

And('RoLSectionTwo click Activate') do
  @rol_section_two_page ||= RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.click_activate
end

And('RoLSectionTwo click Submit') do
  @rol_section_two_page ||= RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.click_submit_btn
end

Given('RoLSectionTwo click Updates Needed') do
  @rol_section_two_page = RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.click_updates_needed_btn
end

Given('RoLSectionTwo enter AA comments {string}') do |text|
  @rol_section_two_page ||= RoLSectionTwoPage.new(@driver)
  @rol_section_two_page.enter_aa_comments(text)
end
