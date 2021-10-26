# frozen_string_literal: true

require_relative '../../../../page_objects/sections/form_prelude_page'

Given('FormPrelude select level1 {string}') do |permit|
  @form_prelude_page ||= FormPreludePage.new(@driver)
  @level1_permit = permit # save for following usage
  @form_prelude_page.select_level1_permit(permit)
end

Given('FormPrelude select level2 {string}') do |permit|
  @level2_permit = permit # save for following usage
  @form_prelude_page.select_level2_permit(permit)
end

Given('FormPrelude back to permit selection') do
  @form_prelude_page.back_to_permit_selection
end

Given('FormPrelude should see select permit type header') do
  @form_prelude_page ||= FormPreludePage.new(@driver)
end

Given('FormPrelude verify level1 permit') do |table|
  @form_prelude_page ||= FormPreludePage.new(@driver)
  @form_prelude_page.verify_level1_list(table)
end

Given('FormPrelude verify level2 list {string}') do |permit|
  @form_prelude_page.verify_level2_list(permit)
end
