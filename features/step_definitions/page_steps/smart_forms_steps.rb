# frozen_string_literal: true

require_relative '../../../page_objects/smart_form_page'

Given('SmartForms open page') do
  @smart_form_page ||= SmartFormsPage.new(@driver)
  @smart_form_page.open_page
end

Given('SmartForms click create permit to work') do
  @smart_form_page.click_create_permit_to_work
end

When('SmartForms click create entry permit') do
  @smart_form_page.click_create_entry_permit
end

And('SmartForms open hamburger menu') do
  @smart_form_page.click_hamburger_menu_btn
end

And('SmartForms verify hamburger categories') do
  @smart_form_page.verify_base_menu
end

And('SmartForms navigate to state page') do |table|
  @smart_form_page ||= SmartFormsPage.new(@driver)
  @smart_form_page.open_state_page(table)
end

And('SmartForms open entry display page') do
  @smart_form_page ||= SmartFormsPage.new(@driver)
  @smart_form_page.open_entry_display
end
