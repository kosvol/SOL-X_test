# frozen_string_literal: true

require_relative '../../../page_objects/smart_form_page'

Given('SmartForms open page') do
  @smart_form_page ||= SmartFormsPage.new(@driver)
  @smart_form_page.open_page
end

Given('SmartForms click create permit to work') do
  @smart_form_page.click_create_permit_to_work
end

When('SmartForms click create {string}') do |permit_type|
  @smart_form_page.click_create_new_pre_btn if permit_type.to_s.upcase == 'PRE'
  @smart_form_page.click_create_new_cre_btn if permit_type.to_s.upcase == 'CRE'
end
