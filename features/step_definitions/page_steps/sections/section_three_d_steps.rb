# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_three_d_page'

Given('Section3D should see location stamp {string}') do |location_stamp|
  @section_three_d_page ||= SectionThreeDPage.new(@driver)
  @section_three_d_page.verify_location_stamp(location_stamp)
end

Given('Section3D verify signature rank {string}') do |rank|
  @section_three_d_page.verify_rank(rank)
end
