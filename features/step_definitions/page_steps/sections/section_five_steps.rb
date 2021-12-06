# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_five_page'

Given('Section5 select role') do |table|
  @section_five_page ||= SectionFivePage.new(@driver)
  @section_five_page.select_role(table)
end

Given('Section5 click Enter PIN & Sign button') do
  @section_five_page ||= SectionFivePage.new(@driver)
  @section_five_page.click_sign_btn
end

Given('Section5 verify signature') do |table|
  @section_five_page.verify_signature(table)
end

Given('Section5 delete role') do |table|
  @section_five_page.delete_role(table)
end

Given('Section5 verify {string}') do |list_type, table|
  @section_five_page.verify_role_list(list_type, table)
end

Given('Section5 verify role full list') do
  @section_five_page ||= SectionFivePage.new(@driver)
  @section_five_page.verify_full_role_list
end

Given('Section5 click Sign as non-crew member') do
  @section_five_page ||= SectionFivePage.new(@driver)
  @section_five_page.click_non_crew_checkbox
end

Given('Section5 verify sign button is {string}') do |option|
  @section_five_page.verify_sign_btn(option)
end

Given('Section5 enter non-crew info') do |table|
  @section_five_page.enter_non_crew_info(table)
end

Given('Section5 verify non-crew hint') do
  @section_five_page.verify_non_crew_hint
end

Given('Section5 verify supervised signature') do |table|
  @section_five_page.verify_supervised_signature(table)
end
