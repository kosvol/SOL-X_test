# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_six_page'

Given('Section6 answer gas reading as {string}') do |option|
  @section_six_page ||= SectionSixPage.new(@driver)
  @section_six_page.answer_gas_reading(option)
end

Given('Section6 verify gas reading note') do
  @section_six_page.verify_note
end

Given('Section6 verify incomplete fields warning') do
  @section_six_page ||= SectionSixPage.new(@driver)
  @section_six_page.verify_field_missing_note
end

Given('Section6 verify incomplete signature warning') do
  @section_six_page ||= SectionSixPage.new(@driver)
  @section_six_page.verify_sign_missing_note
end

Given('Section6 verify submit button is {string}') do |option|
  @section_six_page ||= SectionSixPage.new(@driver)
  @section_six_page.verify_submit_btn(option)
end

Given('Section6 click Add Gas Test Record') do
  @section_six_page ||= SectionSixPage.new(@driver)
  @section_six_page.click_add_gas_record
end

Given('Section6 verify submit button text is {string}') do |text|
  @section_six_page ||= SectionSixPage.new(@driver)
  @section_six_page.verify_submit_btn_text(text)
end

Given('Section6 {string} see gas text fields') do |option|
  @section_six_page.verify_gas_text_fields(option)
end

Given('Section6 {string} see gas testing disabled warning') do |option|
  @section_six_page.verify_gas_disabled_warning(option)
end

Given('Section6 click submit button') do
  @section_six_page ||= SectionSixPage.new(@driver)
  @section_six_page.click_submit_btn
end

Given('Section6 {string} see submit and update button') do |visibility|
  @section_six_page ||= SectionSixPage.new(@driver)
  @section_six_page.verify_submit_update_btn(visibility)
end
