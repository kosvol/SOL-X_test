# frozen_string_literal: true

require_relative '../../../../page_objects/sections/common_section_page'

Given('CommonSection navigate to {string}') do |section|
  @section_navigation_page ||= CommonSectionPage.new(@driver)
  @section_navigation_page.navigate_to_section(section)
end

Given('CommonSection click Save & Next') do
  @section_navigation_page ||= CommonSectionPage.new(@driver)
  @section_navigation_page.click_save_next
end

Given('CommonSection click Previous') do
  @section_navigation_page ||= CommonSectionPage.new(@driver)
  @section_navigation_page.click_previous
end

Given('CommonSection sleep for {string} sec') do |sec|
  sleep sec.to_i
end

Given('CommonSection click sign button') do
  @section_navigation_page ||= CommonSectionPage.new(@driver)
  @section_navigation_page.click_sign_sign
end

And('CommonSection select next date') do
  @common_page ||= CommonSectionPage.new(@driver)
  @common_page.select_next_date
end
