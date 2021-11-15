# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_three_c_page'

Given('Section3C should see dra member {string}') do |rank|
  @section_three_c_page ||= SectionThreeCPage.new(@driver)
  @section_three_c_page.verify_default_dra_member(rank)
end

Given('Section3C select DRA member {string}') do |rank|
  @section_three_c_page ||= SectionThreeCPage.new(@driver)
  @section_three_c_page.add_dra_member(rank)
end

Given('Section3C remove DRA member {string}') do |rank|
  @section_three_c_page ||= SectionThreeCPage.new(@driver)
  @section_three_c_page.remove_dra_member(rank)
end

Given('Section3C should see list dra members') do |table|
  @section_three_c_page.verify_dra_member_list(table)
end
