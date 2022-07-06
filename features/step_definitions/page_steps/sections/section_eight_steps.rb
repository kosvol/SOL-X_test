# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_eight_page'

Given('Section8 verify termination button is {string}') do |option|
  @section_eight_page = SectionEightPage.new(@driver)
  @section_eight_page.verify_termination_btn(option)
end

Given('Section8 verify RA signature section is hidden') do
  @section_eight_page = SectionEightPage.new(@driver)
  @section_eight_page.verify_ra_signature_is_hidden
end

Given('Section8 verify task commenced time') do
  @section_eight_page = SectionEightPage.new(@driver)
  @section_eight_page.verify_commenced_time(@active_ptw_page.issued_time)
end

Given('Section8 verify extra questions') do |table|
  parms = table.hashes.first
  @section_eight_page = SectionEightPage.new(@driver)
  @section_eight_page.verify_extra_question(parms['question_type'], parms['eic'])
end

Given('Section8 click Submit For Termination') do
  @section_eight_page = SectionEightPage.new(@driver)
  @section_eight_page.click_termination_btn
end

Given('Section8 click sign button for {string}') do |type|
  @section_eight_page = SectionEightPage.new(@driver)
  @section_eight_page.click_sign_btn(type)
end

Given('Section8 verify signed detail') do |table|
  @section_eight_page = SectionEightPage.new(@driver)
  @section_eight_page.verify_signed_detail(table)
end

Given('Section8 answer task status {string}') do |task_status|
  @section_eight_page = SectionEightPage.new(@driver)
  @section_eight_page.answer_task_status(task_status)
end

Given('Section8 verify sign button are disabled') do
  @section_eight_page = SectionEightPage.new(@driver)
  @section_eight_page.verify_sign_btn_disabled
end
