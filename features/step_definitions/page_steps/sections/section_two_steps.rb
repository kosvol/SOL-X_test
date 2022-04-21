# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_two_page'

Given('Section2 should see section header') do
  @section_two_page ||= SectionTwoPage.new(@driver)
end

Then('Section2 should see Previous and Next buttons') do
  @section_two_page ||= SectionTwoPage.new(@driver)
  @section_two_page.verify_previous_and_next
end

Then('Section2 check Approving Authority') do |table|
  @section_two_page ||= SectionTwoPage.new(@driver)
  @section_two_page.verify_approving_authority(table.hashes.first)
end
