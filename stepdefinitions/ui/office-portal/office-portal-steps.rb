# frozen_string_literal: true

Given(/^I launch Office Portal$/) do
  $browser.get(EnvironmentSelector.get_environment_url)
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).op_login_btn_element)
end

Then(/^I should see the "([^"]*)" name on the top bar and page body$/) do |name|
  is_equal(on(OfficePortalPage).topbar_header_element.text, name)
  is_equal(on(OfficePortalPage).portal_name_element.text, name)
  sleep(1)
end

When(/^I enter a (valid|invalid) password$/) do |_condition|
  if _condition === 'valid'
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
  to_exists(on(OfficePortalPage).home_btn_element)
  not_to_exists(on(OfficePortalPage).permit_list_element)
end

And(/^I see the checkbox is (checked|unchecked)$/) do |condition|
  if condition == "checked"
    is_true(on(OfficePortalPage).remember_checkbox_element.checked?)
    sleep(1)
  else
    is_false(on(OfficePortalPage).remember_checkbox_element.checked?)
    sleep(1)
  end
end

When(/^I uncheck the checkbox$/) do
  on(OfficePortalPage).remember_box_element.click
  sleep(1)
end

Given(/^I log in to the Office Portal$/) do
  step 'I launch Office Portal'
  step 'I enter a valid password'
  step 'I click on Log In Now button'
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).home_btn_element)
end

Then(/^I should see the vessel name at the top bar and permits list$/) do
  does_include(on(OfficePortalPage).topbar_header_element.text, @vessel)
  does_include(on(OfficePortalPage).permits_list_name_element.text, @vessel)
  sleep(1)
end

And(/^I should see Since item on the vessel card$/) do
  does_include(on(OfficePortalPage).vessel_card_since_date(@vessel), 'Since')
end

And(/^I should see Last Permit (\d+) days ago on the vessel card$/) do |_days|
  is_equal(on(OfficePortalPage).vessel_card_last_permit_date(@vessel), ('Last Permit ' + _days.to_s + ' day(s) ago'))
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
  vessels_list = Array.new
  on(OfficePortalPage).vessel_card_name_elements.each do |vessel|
    name = vessel.text
    vessels_list << name
  end
  order = vessels_list.sort
  is_true(vessels_list == order)
  sleep(1)
end

And(/^I select the permit (\d+)$/) do |_whatPermit|
  on(OfficePortalPage).permit_check_box_elements[_whatPermit].click
  @permit_number = on(OfficePortalPage).get_permit_number(_whatPermit + 1)
  @permit_name = on(OfficePortalPage).get_permit_name(_whatPermit + 1)
end

And(/^I click on View Permit button$/) do
  on(OfficePortalPage).view_permit_btn
  sleep(1)
  $browser.switch_to.window($browser.window_handles[1])
end

Then(/^I should see the selected form in a new tab$/) do
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).permit_section_header_elements[2])
  does_include(on(OfficePortalPage).topbar_header_element.text, @formNumber)
  does_include(on(OfficePortalPage).topbar_header_element.text, @formName)
  sleep(1)
end

And(/^I click on Add Filter button$/) do
  on(OfficePortalPage).add_filter_btn
end

Then(/^I should the Permit Types list for filter$/) do
  permitTypesList = []
  on(OfficePortalPage).filter_permit_type_elements.each do |_whatType|
    type = _whatType.text
    permitTypesList << type
  end
  base_data = YAML.load_file("data/office-portal/office-portal-filters.yml")['types']
  is_true(permitTypesList == base_data)
end

And(/^I check the checkbox near the Permit No. title$/) do
  on(OfficePortalPage).permit_check_box_elements[0].click
end

Then(/^I should see all the forms are (selected|not selected)$/) do |_whatChoiсe|
  if _whatChoiсe == "selected"
    on(OfficePortalPage).permit_checkbox_elements.each do |_selection|
        is_true(_selection.checked?)
      end
  else
    on(OfficePortalPage).permit_checkbox_elements.each do |_selection|
        is_false(_selection.checked?)
      end
  end
end

And(/^I should see the forms quantity on the top bar is the same as on the All Permits title$/) do
  bottomQuantity = on(OfficePortalPage).bottom_bar_permits_quantity_element.text
  does_include(on(OfficePortalPage).all_permits_btn_element.text, bottomQuantity)
end


And(/^I should see the Print Permit button at the bottom bar$/) do
  to_exists(on(OfficePortalPage).print_permit_btn_element)
  sleep(2)
end

Then(/^I should see the form contains 9 sections$/) do
  sectionsList = []
  on(OfficePortalPage).permit_section_header_elements.each do |_whatSection|
    section = _whatSection.text
    sectionsList << section
  end
  sections_data = YAML.load_file("data/office-portal/permit-states-sections.yml")['terminated']
  is_true(sectionsList == sections_data)
end

And(/^I should see This Permit Has been approved on label with the correct date$/) do
  to_exists(on(OfficePortalPage).permit_approved_on_element)
  step 'I scroll down to This Permit Approved On element'
  approved_date = on(OfficePortalPage).get_approved_date_time
  date = on(OfficePortalPage).permit_approved_on_element.text.sub('This Permit Has been approved on ', '')
  does_include(approved_date, date)
end

Given(/^I terminate permit (.+) via service with (.+) user on the (.+) vessel$/) do |_permit_type, _user, _vessel|
  on(BypassPage).trigger_forms_termination(_permit_type, _user, _vessel)
  dataFileResp = JSON.parse JsonUtil.read_json_response('ptw/0.mod_create_form_ptw')
  dateFileReq = JSON.parse JsonUtil.read_json('ptw/0.mod_create_form_ptw')
  @formNumber = dataFileResp['data']['createForm']['_id']
  @formName = dateFileReq['variables']['permitType']
  sleep(2)
end

Then(/^I should see the terminated form at the top of the forms list$/) do
  does_include(on(OfficePortalPage).first_permit_with_time, @formNumber)
  does_include(on(OfficePortalPage).first_permit_with_time, @formName)
end

And(/^I select the recently terminated form$/) do
  on(OfficePortalPage).select_permit_by_number(@formNumber)
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
  expect(on(OfficePortalPage).section_headers_all_elements.last.text).to include("Entry Log")
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

And(/^I log in to the Office Portal with new ENV$/) do
  ENV['ENV_OLD'] = ENV['ENVIRONMENT']
  ENV['APP_OLD'] = ENV['APPLICATION']
  ENV['ENVIRONMENT'] = "office_approval"
  ENV['APPLICATION'] = "office_portal"
  step 'I launch Office Portal'
  on(OfficePortalPage).op_password_element.send_keys($obj_env_yml[$current_environment]['password'])
  step 'I click on Log In Now button'
  BrowserActions.wait_until_is_visible(on(OfficePortalPage).home_btn_element)
  ENV['ENVIRONMENT'] = ENV['ENV_OLD']
  ENV['APPLICATION'] = ENV['ENV_OLD']
end

And(/^I check the checkbox near the current Permit$/) do
  on(OfficePortalPage).select_permit_by_number(@@pre_number)
end

And(/^I check the checkbox near the first permit in the list$/) do
  on(OfficePortalPage).permit_check_box_elements[1].click
end

And(/^I check rank and full name of Entrant without toxic "([^"]*)"$/) do |array|
  #add full name after fix parent task
  i = 1
  yml_id = YAML.load_file('data/sit_rank_and_pin.yml')
  array.split(',').each do |item|
    id = yml_id['rank_name'][item]
    is_equal(on(OfficePortalPage).ese_log_table_title_or_value_elements[10 * i].text, id)
    i += 1
  end
end

And(/^I select filter value with permit type (.+)$/) do |_permit_type|
  #on(OfficePortalPage).input_field_element.send_keys(_permit_type)
  @browser.find_element(:xpath, "//span[contains(text(), #{_permit_type})]/parent::button").click
end
