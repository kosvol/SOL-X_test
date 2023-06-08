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

Given('RoLSectionThree click Submit For Termination') do
  @rol_section_three_page = RoLSectionThreePage.new(@driver)
  @rol_section_three_page.click_termination_btn
end

And('RoLSectionThree click Withdraw Permit To Work') do
  @rol_section_three_page ||= RoLSectionThreePage.new(@driver)
  @rol_section_three_page.click_withdraw
end

Given('RoLSectionThree click request_updates') do
  @rol_section_three_page = RoLSectionThreePage.new(@driver)
  @rol_section_three_page.click_request_updates_btn
end

Given('RoLSectionThree enter AA comments {string}') do |text|
  @rol_section_three_page ||= RoLSectionThreePage.new(@driver)
  @rol_section_three_page.enter_aa_comments(text)
end

Given('RoLSectionThree click Submit') do
  @rol_section_three_page ||= RoLSectionThreePage.new(@driver)
  @rol_section_three_page.click_submit_btn
end
