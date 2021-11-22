# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_four_a_page'

Given('Section4A uncheck all checklist') do
  @section_four_a_page = SectionFourAPage.new(@driver)
  @section_four_a_page.uncheck_all_checklist
end

Given('Section4A select checklist {string}') do |checklist|
  @section_four_a_page = SectionFourAPage.new(@driver)
  @section_four_a_page.select_checklist(checklist)
end

Given('Section4A verify checklist') do |table|
  @section_four_a_page = SectionFourAPage.new(@driver)
  @section_four_a_page.verify_checklist(table)
end

Given('Section4A verify pre-selected checklist {string}') do |checklist|
  @section_four_a_page = SectionFourAPage.new(@driver)
  @section_four_a_page.verify_pre_selected(checklist)
end
