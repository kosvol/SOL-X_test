# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_four_b_page'

Given('Section4B select Yes for EIC') do
  @section_four_b_page ||= SectionFourBPage.new(@driver)
  @section_four_b_page.select_yes_for_eic
end

Given('Section4B click create EIC') do
  @section_four_b_page.click_create_eic
end

Given('Section4B click sign button') do
  @section_four_b_page ||= SectionFourBPage.new(@driver)
  @section_four_b_page.click_sign_btn
end

Given('Section4B should see location stamp {string}') do |location|
  @section_four_b_page.verify_location_stamp(location)
end

Given('Section4B verify signature rank {string}') do |rank|
  @section_four_b_page.verify_rank_name(rank)
end
