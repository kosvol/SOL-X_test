# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_seven_page'

Given('Section7 verify activate button is {string}') do |option|
  @section_seven_page = SectionSevenPage.new(@driver)
  @section_seven_page.verify_activate_btn(option)
end

Given('Section7 verify request update button is {string}') do |option|
  @section_seven_page.verify_request_update_btn(option)
end

Given('Section7 click Activate') do
  @section_seven_page = SectionSevenPage.new(@driver)
  @section_seven_page.click_activate
end

Given('Section7 click Request Updates') do
  @section_seven_page = SectionSevenPage.new(@driver)
  @section_seven_page.click_request_update_btn
end

Given('Section7 click Submit') do
  @section_seven_page = SectionSevenPage.new(@driver)
  @section_seven_page.click_submit_btn
end

Given('Section7 enter AA comments {string}') do |text|
  @section_seven_page ||= SectionSevenPage.new(@driver)
  @section_seven_page.enter_aa_comments(text)
end
