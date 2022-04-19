# frozen_string_literal: true

require_relative '../../../../page_objects/office_portal/op_login_page'

Given('OfficeLogin open page') do
  @office_portal_login ||= OPLoginPage.new(@driver)
  @office_portal_login.open_op_page
end

Then('OfficeLogin should see all the Login page attributes') do
  @office_portal_login ||= OPLoginPage.new(@driver)
  @office_portal_login.verify_login_page_attributes
end

And('OfficeLogin click the Sign in button') do
  @office_portal_login ||= OPLoginPage.new(@driver)
  @office_portal_login.click_sign_in
end

And('OfficeLogin should see the {string} field is highlighted in red') do |field|
  @office_portal_login ||= OPLoginPage.new(@driver)
  @office_portal_login.verify_highlighted_in_red(field)
end

When('OfficeLogin enter email {string}') do |text|
  @office_portal_login ||= OPLoginPage.new(@driver)
  @office_portal_login.enter_email(text)
end

When('OfficeLogin enter password {string}') do |text|
  @office_portal_login ||= OPLoginPage.new(@driver)
  @office_portal_login.enter_password(text)
end

And('OfficeLogin should see the error message below the heading') do |table|
  @office_portal_login ||= OPLoginPage.new(@driver)
  @office_portal_login.verify_error_message(table)
end

When('OfficeLogin click Forgot password') do
  @office_portal_login.click_forgot_password
end

And('OfficeLogin remove password') do
  @office_portal_login.remove_password
end

# The following steps to be removed after refactoring is finished
And(/^I select the permit (\d+)$/) do |what_permit|
  on(OfficePortalPage).permit_check_box_elements[what_permit].click
  @permit_number = on(OfficePortalPage).get_permit_number(what_permit + 1)
  @permit_name = on(OfficePortalPage).get_permit_name(what_permit + 1)
end

Then(/^I should see the selected form in a new tab$/) do
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).permit_section_header_elements[2])
  does_include(on(OfficePortalPage).topbar_header_element.text, @form_number)
  does_include(on(OfficePortalPage).topbar_header_element.text, @form_name)
  sleep(1)
end

Then(/^I should see all the forms are (selected|not selected)$/) do |what_choice|
  if what_choice == 'selected'
    on(OfficePortalPage).permit_checkbox_elements.each do |selection|
      is_true(selection.checked?)
    end
  else
    on(OfficePortalPage).permit_checkbox_elements.each do |selection|
      is_false(selection.checked?)
    end
  end
end

And(/^I should see the Print Permit button at the bottom bar$/) do
  to_exists(on(OfficePortalPage).print_permit_btn_element)
  sleep(2)
end

Then(/^I should see the form contains 9 sections$/) do
  sections_list = []
  on(OfficePortalPage).permit_section_header_elements.each do |what_section|
    section = what_section.text
    sections_list << section
  end
  sections_data = YAML.load_file('data/office-portal/permit-states-sections.yml')['terminated']
  is_true(sections_list == sections_data)
end

And(/^I should see This Permit Has been approved on label with the correct date$/) do
  to_exists(on(OfficePortalPage).permit_approved_on_element)
  step 'I scroll down to This Permit Approved On element'
  approved_date = on(OfficePortalPage).approved_date_time
  date = on(OfficePortalPage).permit_approved_on_element.text.sub('This Permit Has been approved on ', '')
  does_include(approved_date, date)
end

And(/^I check that Entry log is present$/) do
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).permit_section_header_elements[2])
  sleep 2
  expect(on(OfficePortalPage).section_headers_all_elements.last.text).to include('Entry Log')
end

And(/^I check all headers of Entry Log table without toxic gas on portal$/) do
  is_equal(on(OfficePortalPage).ese_log_table_title_or_value_elements[0].text, 'Entrant')
  is_equal(on(OfficePortalPage).ese_log_table_title_or_value_elements[1].text, 'Purpose')
  is_equal(on(OfficePortalPage).ese_log_table_title_or_value_elements[2].text, 'Validity')
  is_equal(on(OfficePortalPage).ese_log_table_title_or_value_elements[3].text, 'Time In/Out')
  is_equal(on(OfficePortalPage).ese_log_table_title_or_value_elements[4].text, 'GMT')
  is_equal(on(OfficePortalPage).ese_log_table_title_or_value_elements[5].text, 'O2')
  is_equal(on(OfficePortalPage).ese_log_table_title_or_value_elements[6].text, 'HC')
  is_equal(on(OfficePortalPage).ese_log_table_title_or_value_elements[7].text, 'H2S')
  is_equal(on(OfficePortalPage).ese_log_table_title_or_value_elements[8].text, 'CO')
  is_equal(on(OfficePortalPage).ese_log_table_title_or_value_elements[9].text, 'Competent Person')
end

And(/^I create ([^"]*) via service with static env$/) do |type|
  ENV['ENV_OLD'] = ENV['ENVIRONMENT']
  ENV['ENVIRONMENT'] = 'auto'
  case type
  when 'PRE'
    step 'I submit a scheduled PRE permit'
    step 'I sleep for 85 seconds'
    step 'I terminate the PRE permit via service'
  when 'submit_enclose_space_entry'
    step "I submit permit #{type} via service with 8383 user and set to active state with gas reading require"
    step 'I add new entry "A 2/O" PTW'
    step 'I sleep for 3 seconds'
    step 'I acknowledge the new entry log via service'
    step 'I sleep for 3 seconds'
    step 'I Close Permit submit_enclose_space_entry via service auto'
    step 'I sleep for 3 seconds'
  when 'CRE'
    puts 'to do'
  else
    raise 'Wrong condition'
  end
  ENV['ENVIRONMENT'] = ENV['ENV_OLD']
end

And(/^I check the checkbox near the current Permit$/) do
  on(OfficePortalPage).select_permit_by_number(@@pre_number)
end

And(/^I check the checkbox near the first permit in the list$/) do
  on(OfficePortalPage).permit_check_box_elements[1].click
end

And(/^I check rank and full name of Entrant without toxic "([^"]*)"$/) do |array|
  # add full name after fix parent task
  i = 1
  yml_id = YAML.load_file('data/sit_rank_and_pin.yml')
  array.split(',').each do |item|
    id = yml_id['rank_name'][item]
    is_equal(on(OfficePortalPage).ese_log_table_title_or_value_elements[10 * i].text, id)
    i += 1
  end
end
