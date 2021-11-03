# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_three_b_page'

Given('Section3B answer work site inspection carried out {string}') do |answer|
  @section_three_b_page ||= SectionThreeBPage.new(@driver)
  @section_three_b_page.answer_work_site_inspection(answer)
end

Given('Section3B {string} see inspection crew list') do |option|
  @section_three_b_page ||= SectionThreeBPage.new(@driver)
  @section_three_b_page.verify_work_site_answer(option)
end

Given('Section3B verify method description {string}') do |expected|
  @section_three_b_page ||= SectionThreeBPage.new(@driver)
  @section_three_b_page.verify_method_description(expected)
end

Given('Section3B verify DRA been sent answer') do
  @section_three_b_page ||= SectionThreeBPage.new(@driver)
  @section_three_b_page.verify_dra_been_sent
end
