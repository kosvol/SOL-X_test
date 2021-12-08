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

And('SmartForms click show more on {string}') do |category|
  @smart_form_page.click_show_more_btn(category)
end

And('SmartForms open hamburger menu') do
  @smart_form_page.click_hamburger_menu_btn
end

And('SmartForms verify hamburger categories') do
  @smart_form_page.verify_base_menu
end

And('SmartForms navigate to {string} page for {string}') do |page, category|
  @smart_form_page.click_hamburger_menu_btn
  @smart_form_page.navigate_to_page(page, category)
end

And('SmartForms navigate to {string} display until see active permit') do |permit_type|
  @smart_form_page.wait_until_permit_activate(permit_type)
end

And('SmartForms click back arrow button') do
  @smart_form_page.click_back_arrow
end

And('SmartForms click go back button') do
  @smart_form_page.click_go_back
end
