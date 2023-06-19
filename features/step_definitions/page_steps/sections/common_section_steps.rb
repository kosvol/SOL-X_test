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

And('CommonSection click Back to Home button') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.click_back_to_home_btn
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

Given('CommonSection click Save button') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.click_save
end

Given('CommonSection click Save & Close button') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.click_save_close_btn
end

Given('CommonSection fill up maintenance required fields') do
  steps %(
    And Section1 answer duration of maintenance over 2 hours as "No"
    And Section1 select zone
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    And CommonSection click sign button
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Enter PIN & Sign button
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection click Save & Next
    And Section6 save permit id
    And Section6 answer gas reading as "N/A"
    And Section6 click submit button
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    )
end

Given('CommonSection fill up required fields') do
  steps %(
    And Section1 select zone
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection navigate to "Section 4A"
    And CommonSection click Save & Next
    And CommonSection click sign button
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection navigate to "Section 5"
    And Section5 select role
      | Authorized Entrant 1 |
    And Section5 click Enter PIN & Sign button
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    And CommonSection click Save & Next
    And Section6 save permit id
    And Section6 answer gas reading as "N/A"
    And Section6 click submit button
    And PinEntry enter pin for rank "C/O"
    And SignatureLocation sign off
      | area      | zone                  |
      | Main Deck | No. 1 Cargo Tank Port |
    )
end

Given('CommonSection {string} see camera button') do |visibility|
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.verify_camera_btn(visibility)
end

Given('CommonSection click camera button') do
  @common_section_page ||= CommonSectionPage.new(@driver)
  @common_section_page.click_camera_btn
end
