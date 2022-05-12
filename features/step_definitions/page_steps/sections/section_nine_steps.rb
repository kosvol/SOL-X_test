# frozen_string_literal: true

require_relative '../../../../page_objects/sections/section_nine_page'

Given('Section9 verify withdraw button is {string}') do |option|
  @section_nine_page ||= SectionNinePage.new(@driver)
  @section_nine_page.verify_withdraw_btn(option)
end

Given('Section9 verify withdrawn signature section is hidden') do
  @section_nine_page ||= SectionNinePage.new(@driver)
  @section_nine_page.verify_signature_is_hidden
end

Given('Section9 verify request updates button is {string}') do |option|
  @section_nine_page.verify_request_update_btn(option)
end

And('Section9 click Withdraw Permit To Work') do
  @section_nine_page ||= SectionNinePage.new(@driver)
  @section_nine_page.click_withdraw
end
