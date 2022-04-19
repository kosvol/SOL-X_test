# frozen_string_literal: true

require_relative '../../../../page_objects/sections/common_section_page'

Given('CommonSection navigate to {string}') do |section|
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.navigate_to_section(section)
  sleep 1 # to make it stable
end

Given('CommonSection click Save & Next') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.click_save_next
end

Given('CommonSection click Previous') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.click_previous
end

Given('CommonSection sleep for {string} sec') do |sec|
  sleep sec.to_i
end

Given('CommonSection click sign button') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.click_sign_sign
end

Given('CommonSection click Back button') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.click_back_btn
end

Given('CommonSection click Close button') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.click_close_btn
end

Given('CommonSection click Next button') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.click_next_btn
end

And('CommonSection verify button availability') do |table|
  @common_section_page ||= CommonSectionPage.new(@driver)
  params = table.hashes.first
  @common_section_page.verify_button(params['button'], params['availability'])
end

And('CommonSection verify header is {string}') do |expected_header|
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.verify_header_text(expected_header)
end
