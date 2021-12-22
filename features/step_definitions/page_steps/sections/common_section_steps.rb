# frozen_string_literal: true

require_relative '../../../../page_objects/sections/common_section_page'

Given('CommonSection navigate to {string}') do |section|
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.navigate_to_section(section)
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

And('CommonSection open current permit for view') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.open_ptw_for_view
end

And('CommonSection verify button {string}') do |button|
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.verify_button_enabled(button)
end

And('CommonSection verify button {string} is disabled') do |button|
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.verify_button_disabled(button)
end

Then('CommonSection check Responsible Officer Signature') do |table|
  @common_section_page ||= CommonSectionPage.new(@driver)
  params = table.hashes.first
  @common_section_page.check_ra_signature(params['rank'], params['zone'])
end

And('CommonSection save permit id from list') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.save_ptw_id_from_list
end

And('CommonSection verify current permit presents in the list') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.verify_permit
end