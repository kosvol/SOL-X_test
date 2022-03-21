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

Then(/^I should see the "([^"]*)" name on the top bar and page body$/) do |name|
  is_equal(on(OfficePortalPage).topbar_header_element.text, name)
  is_equal(on(OfficePortalPage).portal_name_element.text, name)
  sleep(1)
end

When(/^I enter a (valid|invalid) password$/) do |condition|
  if condition == 'valid'
    on(OfficePortalPage).op_password_element.send_keys($password)
  else
    on(OfficePortalPage).op_password_element.send_keys('text')
  end
  sleep(1)
end

And(/^I click on Log In Now button$/) do
  on(OfficePortalPage).op_login_btn
  sleep(1)
end

Then(/^I should see the Vessel List page$/) do
  to_exists(on(OfficePortalPage).reporting_header_element)
  to_exists(on(OfficePortalPage).permit_archive_tab_element)
  not_to_exists(on(OfficePortalPage).permit_list_element)
end

And(/^I see the checkbox is (checked|unchecked)$/) do |condition|
  if condition == 'checked'
    is_true(on(OfficePortalPage).remember_checkbox_element.checked?)
  else
    is_false(on(OfficePortalPage).remember_checkbox_element.checked?)
  end
  sleep(1)
end

When(/^I uncheck the checkbox$/) do
  on(OfficePortalPage).remember_box_element.click
  sleep(1)
end

Given(/^I log in to the Office Portal$/) do
  step 'I launch Office Portal'
  step 'I enter a valid password'
  step 'I click on Log In Now button'
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).reporting_header_element)
end

Then(/^I should see the vessel name at the top bar and permits list$/) do
  does_include(on(OfficePortalPage).topbar_header_element.text, @vessel)
  does_include(on(OfficePortalPage).permits_list_name_element.text, @vessel)
  sleep(1)
end

And(/^I should see Since item on the vessel card$/) do
  does_include(on(OfficePortalPage).vessel_card_since_date(@vessel), 'Since')
end

And(/^I should see Last Permit (\d+) days ago on the vessel card$/) do |days|
  is_equal(on(OfficePortalPage).vessel_card_last_permit_date(@vessel), "Last Permit #{days} day(s) ago")
end

When(/^I select the "([^"]*)" vessel$/) do |vessel|
  @vessel = vessel
  on(OfficePortalPage).select_vessel(@vessel)
  sleep(1)
end

And(/^I click on the Home icon$/) do
  on(OfficePortalPage).home_btn
  sleep(1)
end

And(/^I click on the Cross icon$/) do
  on(OfficePortalPage).permit_list_cross_btn_element.click
  sleep(1)
end

Then(/^I check the forms number on the vessel card$/) do
  @permits_quantity = on(OfficePortalPage).vessel_card_permits_quantity(@vessel)
end

Then(/^I should see the same number on the All Permits$/) do
  does_include(on(OfficePortalPage).all_permits_btn_element.text, @permits_quantity)
  sleep(1)
end

Then(/^I should see vessel cards are in alphanumeric order$/) do
  vessels_list = []
  on(OfficePortalPage).vessel_card_name_elements.each do |vessel|
    name = vessel.text
    vessels_list << name
  end
  order = vessels_list.sort
  is_true(vessels_list == order)
  sleep(1)
end

And(/^I select the permit (\d+)$/) do |what_permit|
  on(OfficePortalPage).permit_check_box_elements[what_permit].click
  @permit_number = on(OfficePortalPage).get_permit_number(what_permit + 1)
  @permit_name = on(OfficePortalPage).get_permit_name(what_permit + 1)
end

And(/^I click on View Permit button$/) do
  on(OfficePortalPage).view_permit_btn
  sleep(1)
  $browser.switch_to.window($browser.window_handles[1])
end

Then(/^I should see the selected form in a new tab$/) do
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).permit_section_header_elements[2])
  does_include(on(OfficePortalPage).topbar_header_element.text, @form_number)
  does_include(on(OfficePortalPage).topbar_header_element.text, @form_name)
  sleep(1)
end

And(/^I click on Add Filter button$/) do
  on(OfficePortalPage).add_filter_btn
end

Then(/^I should the Permit Types list for filter$/) do
  permit_types_list = []
  on(OfficePortalPage).filter_permit_type_elements.each do |what_type|
    type = what_type.text
    permit_types_list << type
  end
  base_data = YAML.load_file('data/office-portal/office-portal-filters.yml')['types']
  is_true(permit_types_list == base_data)
end

And(/^I check the checkbox near the Permit No. title$/) do
  on(OfficePortalPage).permit_check_box_elements[0].click
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

And(/^I should see the forms quantity on the top bar is the same as on the All Permits title$/) do
  bottom_quantity = on(OfficePortalPage).bottom_bar_permits_quantity_element.text
  does_include(on(OfficePortalPage).all_permits_btn_element.text, bottom_quantity)
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

Given(/^I terminate permit (.+) via service with (.+) user on the (.+) vessel$/) do |permit_type, user, vessel|
  on(BypassPage).trigger_forms_termination(permit_type, user, vessel, nil, nil, nil)
  @permit_type = permit_type
  data_file_resp = JSON.parse JsonUtil.read_json_response('ptw/0.mod_create_form_ptw')
  date_file_req = JSON.parse JsonUtil.read_json('ptw/0.mod_create_form_ptw')
  @form_number = data_file_resp['data']['createForm']['_id']
  @form_name = date_file_req['variables']['permitType']
  sleep(2)
end

Then(/^I should see the terminated form at the top of the forms list$/) do
  does_include(on(OfficePortalPage).first_permit_with_time, @form_number)
  does_include(on(OfficePortalPage).first_permit_with_time, @form_name)
end

And(/^I select the recently terminated form$/) do
  on(OfficePortalPage).select_permit_by_number(@form_number)
end

Then(/^I should see the the form number is updated$/) do
  is_true(@permits_quantity.to_i == (@previous_quantity.to_i + 1))
  sleep(1)
end

And(/^I remember the current permits quantity$/) do
  step 'I check the forms number on the vessel card'
  @previous_quantity = @permits_quantity
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

And(/^I select filter value with permit type (.+)$/) do |permit_type|
  # on(OfficePortalPage).input_field_element.send_keys(permit_type)
  $browser.find_element(:xpath, "//span[contains(text(), #{permit_type})]/parent::button").click
end

And(/^I check the element value "([^"]*)" by title "([^"]*)"$/) do |value, title|
  is_equal(on(OfficePortalPage).select_element_by_text_near(title).text, value)
end

Given(/^I terminate permit (.+) via service with (.+) user on the (.+) vessel with the (.*) checklist$/) do |permit_type,
  user, vessel, checklist|
  on(BypassPage).trigger_forms_termination(permit_type, user, vessel, checklist, nil, nil)
  data_file_resp = JSON.parse JsonUtil.read_json_response('ptw/0.mod_create_form_ptw')
  date_file_req = JSON.parse JsonUtil.read_json('ptw/0.mod_create_form_ptw')
  @form_number = data_file_resp['data']['createForm']['_id']
  @form_name = date_file_req['variables']['permitType']
  sleep(2)
end

Then(/^I should see (.+) checklist questions in Office Portal$/) do |checklist|
  questions_arr = on(OfficePortalPage).questions?(checklist)
  base_data = ['Vessel Name:', 'Created On:']
  base_data = base_data + YAML
              .load_file("data/checklist/#{checklist}.yml")['questions'] - YAML
              .load_file('data/checklist/checklist_exceptions.yml')['exceptions']
  p "> difference #{questions_arr - base_data}"
  is_equal(questions_arr, base_data)
end

Then(/^I should see the ([^"]*) shows the same fields as in the Client app$/) do |what_section|
  fields_arr = []
  labels_arr = []
  subheaders_arr = []
  if what_section == 'Energy Isolation Certificate'
    $browser.find_elements(:xpath, "(//h2[contains(text(),'#{what_section}')])[5]/../..//h4").each do |field|
      fields_arr << field.text
    end
    $browser.find_elements(:xpath, "(//h2[contains(text(),'#{what_section}')])[5]/../..//label").each do |label|
      labels_arr << label.text
    end
    $browser.find_elements(:xpath, "(//h2[contains(text(),'#{what_section}')])[5]/../..//h2").each do |subheader|
      subheaders_arr << subheader.text
    end
  else
    $browser.find_elements(:xpath, "//h2[contains(text(),'#{what_section}')]/../..//h4").each do |field|
      fields_arr << field.text
    end
    $browser.find_elements(:xpath, "//h2[contains(text(),'#{what_section}')]/../..//label").each do |label|
      labels_arr << label.text
    end
    $browser.find_elements(:xpath, "//h2[contains(text(),'#{what_section}')]/../..//h2").each do |subheader|
      subheaders_arr << subheader.text
    end
  end
  base_fields = if @permit_type == 'submit_maintenance_on_anchor'
                  [] + YAML.load_file("data/screens-label/#{what_section}.yml")['fields_maintenance']
                else
                  [] + YAML.load_file("data/screens-label/#{what_section}.yml")['fields']
                end
  base_labels = [] + YAML.load_file("data/screens-label/#{what_section}.yml")['labels']
  base_subheaders = if @form_number.include? 'FSU'
                      [] + YAML.load_file("data/screens-label/#{what_section}.yml")['subheaders_fsu']
                    else
                      [] + YAML.load_file("data/screens-label/#{what_section}.yml")['subheaders']
                    end
  # exceptions
  fields_arr -= YAML.load_file("data/screens-label/#{what_section}.yml")['fields_exceptions']
  labels_arr -= YAML.load_file("data/screens-label/#{what_section}.yml")['labels_exceptions']
  subheaders_arr -= YAML.load_file("data/screens-label/#{what_section}.yml")['subheaders_exceptions']
  p ">>> difference #{fields_arr - base_fields}"
  p ">> difference #{labels_arr - base_labels}"
  p "> difference #{subheaders_arr - base_subheaders}"
  is_equal(fields_arr, base_fields)
  is_equal(labels_arr, base_labels)
  is_equal(subheaders_arr, base_subheaders)
end

Given(/^I terminate permit (.+) via service with (.+) user on the (.+) vessel with the EIC (.+)$/) do |permit_type, user,
  vessel, eic|
  on(BypassPage).trigger_forms_termination(permit_type, user, vessel, nil, eic, nil)
  data_file_resp = JSON.parse JsonUtil.read_json_response('ptw/0.mod_create_form_ptw')
  date_file_req = JSON.parse JsonUtil.read_json('ptw/0.mod_create_form_ptw')
  @form_number = data_file_resp['data']['createForm']['_id']
  @form_name = date_file_req['variables']['permitType']
  sleep(2)
end

Given(/^I terminate permit (.+) via service with (.+) user on the (.+) vessel with the Gas Readings (.+)$/) do |permit_type,
  user, vessel, gas|
  on(BypassPage).trigger_forms_termination(permit_type, user, vessel, nil, nil, gas)
  data_file_resp = JSON.parse JsonUtil.read_json_response('ptw/0.mod_create_form_ptw')
  date_file_req = JSON.parse JsonUtil.read_json('ptw/0.mod_create_form_ptw')
  @form_number = data_file_resp['data']['createForm']['_id']
  @form_name = date_file_req['variables']['permitType']
  sleep(2)
end

Then(/^Then I should see the Section 6 with gas (.+) shows the same fields as in the Client app$/) do |condition|
  fields_arr = []
  subheaders_arr = []
  $browser.find_elements(:xpath, "//h2[contains(text(),'Section 6')]/../..//h4").each do |field|
    fields_arr << field.text
  end
  $browser.find_elements(:xpath, "//h2[contains(text(),'Section 6')]/../..//h2").each do |subheader|
    subheaders_arr << subheader.text
  end
  base_fields = [] + YAML.load_file('data/screens-label/Section 6.yml')["fields_#{condition}"]
  base_subheaders = [] + YAML.load_file('data/screens-label/Section 6.yml')['subheaders']
  # exceptions
  fields_arr -= YAML.load_file('data/screens-label/Section 6.yml')['fields_exceptions']
  subheaders_arr -= YAML.load_file('data/screens-label/Section 6.yml')['subheaders_exceptions']
  p ">>> difference #{fields_arr - base_fields}"
  p "> difference #{subheaders_arr - base_subheaders}"
  is_equal(fields_arr, base_fields)
  is_equal(subheaders_arr, base_subheaders)
end

Then(/^I should see the (.*) shows the same fields as in the Client app with (.*)$/) do |section, condition|
  fields_arr = []
  subheaders_arr = []
  $browser.find_elements(:xpath, "//h2[contains(text(),'#{section}')]/../..//h4").each do |field|
    fields_arr << field.text
  end
  $browser.find_elements(:xpath, "//h2[contains(text(),'#{section}')]/../..//h2").each do |subheader|
    subheaders_arr << subheader.text
  end
  base_fields = [] + YAML.load_file("data/screens-label/#{section}.yml")["fields_#{condition}"]
  base_subheaders = if @form_number.include? 'FSU'
                      [] + YAML.load_file("data/screens-label/#{section}.yml")["subheaders_#{condition}_fsu"]
                    else
                      [] + YAML.load_file("data/screens-label/#{section}.yml")["subheaders_#{condition}"]
                    end
  # exceptions
  fields_arr -= YAML.load_file("data/screens-label/#{section}.yml")['fields_exceptions']
  subheaders_arr -= YAML.load_file("data/screens-label/#{section}.yml")['subheaders_exceptions']
  p ">>> difference #{fields_arr - base_fields}"
  p "> difference #{subheaders_arr - base_subheaders}"
  is_equal(fields_arr, base_fields)
  is_equal(subheaders_arr, base_subheaders)
end

Then(/^I should see Section 8 shows the same fields as in the Client app with (.*)$/) do |checklist|
  case checklist
  when 'Critical Equipment Maintenance'
    checklist = 'critical'
  when 'Work on Electrical Equipment and Circuits'
    checklist = 'electrical'
  when 'Work on Pressure Pipelines'
    checklist = 'pipe'
  else
    raise "Wrong Checklist >>> #{checklist}"
  end
  fields_arr = []
  subheaders_arr = []
  $browser.find_elements(:xpath, "//h2[contains(text(),'Section 8')]/../..//h4").each do |field|
    fields_arr << field.text
  end
  $browser.find_elements(:xpath, "//h2[contains(text(),'Section 8')]/../..//h2").each do |subheader|
    subheaders_arr << subheader.text
  end
  base_fields = [] + YAML.load_file('data/screens-label/Section 8.yml')["fields_#{checklist}"]
  base_subheaders = [] + YAML.load_file('data/screens-label/Section 8.yml')['subheaders_eic_no']
  # exceptions
  fields_arr -= YAML.load_file('data/screens-label/Section 8.yml')['fields_exceptions']
  subheaders_arr -= YAML.load_file('data/screens-label/Section 8.yml')['subheaders_exceptions']
  p ">>> difference #{fields_arr - base_fields}"
  p "> difference #{subheaders_arr - base_subheaders}"
  is_equal(fields_arr, base_fields)
  is_equal(subheaders_arr, base_subheaders)
end

Then(/^I should see the PRE form shows the same fields as in the client app$/) do
  fields_arr = []
  subheaders_arr = []
  $browser.find_elements(:xpath, '//h4').each do |field|
    fields_arr << field.text
  end
  $browser.find_elements(:xpath, '//h2').each do |subheader|
    subheaders_arr << subheader.text
  end
  base_fields = [] + YAML.load_file('data/pre/pre-display.yml')['pre_structure_on_pred']['with_interval']
  base_subheaders = [] + YAML.load_file('data/pre/pre-display.yml')['subheaders']
  base_fields -= YAML.load_file('data/pre/pre-display.yml')['fields_exceptions']
  p ">>> difference #{fields_arr - base_fields}"
  p "> difference #{subheaders_arr - base_subheaders}"
  is_equal(fields_arr, base_fields)
  is_equal(subheaders_arr, base_subheaders)
end

And(/^I open the recently terminated form with link$/) do
  $browser.get(format($obj_env_yml['office_approval']['office_portal_permit_view'], @form_number))
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).permit_section_header_elements[0])
end
