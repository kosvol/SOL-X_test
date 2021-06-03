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
  on(BypassPage).trigger_forms_termination(_permit_type, _user, _vessel, nil, nil, nil)
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

And(/^I create ([^"]*) via service with static env$/) do |_type|
  ENV['ENV_OLD'] = ENV['ENVIRONMENT']
  ENV['ENVIRONMENT'] = "auto"
  if _type === 'PRE'
    step 'I submit a scheduled PRE permit'
    step 'I sleep for 85 seconds'
    step 'I terminate the PRE permit via service'
  elsif _type === 'submit_enclose_space_entry'
    step "I submit permit #{_type} via service with 8383 user and set to active state with gas reading require"
    step 'I add new entry "A 2/O" PTW'
    step 'I sleep for 3 seconds'
    step 'I acknowledge the new entry log via service'
    step 'I sleep for 3 seconds'
    step 'I Close Permit submit_enclose_space_entry via service auto'
    step 'I sleep for 3 seconds'
  elsif _type === 'CRE'
    puts "to do"
  else
    raise "Wrong condition"
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

And(/^I check the element value "([^"]*)" by title "([^"]*)"$/) do |_value, _title|
  is_equal(on(OfficePortalPage).select_element_by_text_near(_title).text, _value)
end


Given(/^I terminate permit (.+) via service with (.+) user on the (.+) vessel with the (.*) checklist$/) do |_permit_type, _user, _vessel, _checklist|
  on(BypassPage).trigger_forms_termination(_permit_type, _user, _vessel, _checklist, nil, nil)
  dataFileResp = JSON.parse JsonUtil.read_json_response('ptw/0.mod_create_form_ptw')
  dateFileReq = JSON.parse JsonUtil.read_json('ptw/0.mod_create_form_ptw')
  @formNumber = dataFileResp['data']['createForm']['_id']
  @formName = dateFileReq['variables']['permitType']
  sleep(2)
end

Then(/^I should see (.+) checklist questions in Office Portal$/) do |_checklist|
  questionsArr = []
  if _checklist == "Work on Pressure Pipelines"
    $browser.find_elements(:xpath, "//h2[contains(text(),'Work on Pressure Pipeline/Pressure Vessels')]/../..//h4").each do |_question|
      questionsArr << _question.text
    end
  elsif _checklist == "Working Aloft Overside"
    $browser.find_elements(:xpath, "//h2[contains(text(),'Working Aloft/Overside')]/../..//h4").each do |_question|
      questionsArr << _question.text
    end
  elsif _checklist == "Enclosed Spaces Entry Checklist"
    $browser.find_elements(:xpath, "//h2[contains(text(),'Enclosed Spaces Entry')]/../..//h4").each do |_question|
      questionsArr << _question.text
    end
  elsif
    $browser.find_elements(:xpath, "//h2[contains(text(),'#{_checklist}')]/../..//h4").each do |_question|
      questionsArr << _question.text
    end
  end
  base_data = ["Vessel Name:", "Created On:"]
  base_data = base_data + YAML.load_file("data/checklist/#{_checklist}.yml")['questions'] - YAML.load_file("data/checklist/checklist_exceptions.yml")['exceptions']
  p "> difference #{questionsArr - base_data}"
  is_equal(questionsArr, base_data)
end

Then(/^I should see the ([^"]*) shows the same fields as in the Client app$/) do |_whatSection|
  fieldsArr = []
  labelsArr = []
  subheadersArr = []
  if _whatSection == 'Energy Isolation Certificate'
    $browser.find_elements(:xpath, "(//h2[contains(text(),'#{_whatSection}')])[2]/../..//h4").each do |_field|
      fieldsArr << _field.text
    end
    $browser.find_elements(:xpath, "(//h2[contains(text(),'#{_whatSection}')])[2]/../..//label").each do |_label|
      labelsArr << _label.text
    end
    $browser.find_elements(:xpath, "(//h2[contains(text(),'#{_whatSection}')])[2]/../..//h2").each do |_subheader|
      subheadersArr << _subheader.text
    end
  else
    $browser.find_elements(:xpath, "//h2[contains(text(),'#{_whatSection}')]/../..//h4").each do |_field|
      fieldsArr << _field.text
    end
    $browser.find_elements(:xpath, "//h2[contains(text(),'#{_whatSection}')]/../..//label").each do |_label|
      labelsArr << _label.text
    end
    $browser.find_elements(:xpath, "//h2[contains(text(),'#{_whatSection}')]/../..//h2").each do |_subheader|
      subheadersArr << _subheader.text
    end
  end
  baseFields = [] + YAML.load_file("data/screens-label/#{_whatSection}.yml")['fields']
  baseLabels  = [] + YAML.load_file("data/screens-label/#{_whatSection}.yml")['labels']
  baseSubheaders = [] + YAML.load_file("data/screens-label/#{_whatSection}.yml")['subheaders']
  #exceptions
  fieldsArr -= YAML.load_file("data/screens-label/#{_whatSection}.yml")['fields_exceptions']
  labelsArr -= YAML.load_file("data/screens-label/#{_whatSection}.yml")['labels_exceptions']
  subheadersArr -= YAML.load_file("data/screens-label/#{_whatSection}.yml")['subheaders_exceptions']
  p ">>> difference #{fieldsArr - baseFields}"
  p ">> difference #{labelsArr - baseLabels}"
  p "> difference #{subheadersArr - baseSubheaders}"
  is_equal(fieldsArr, baseFields)
  is_equal(labelsArr, baseLabels)
  is_equal(subheadersArr, baseSubheaders)
end

Given(/^I terminate permit (.+) via service with (.+) user on the (.+) vessel with the EIC (.+)$/) do |_permit_type, _user, _vessel, _eic|
  on(BypassPage).trigger_forms_termination(_permit_type, _user, _vessel, nil, _eic, nil)
  dataFileResp = JSON.parse JsonUtil.read_json_response('ptw/0.mod_create_form_ptw')
  dateFileReq = JSON.parse JsonUtil.read_json('ptw/0.mod_create_form_ptw')
  @formNumber = dataFileResp['data']['createForm']['_id']
  @formName = dateFileReq['variables']['permitType']
  sleep(2)
end

Given(/^I terminate permit (.+) via service with (.+) user on the (.+) vessel with the Gas Readings (.+)$/) do |_permit_type, _user, _vessel, _gas|
  on(BypassPage).trigger_forms_termination(_permit_type, _user, _vessel, nil, nil, _gas)
  dataFileResp = JSON.parse JsonUtil.read_json_response('ptw/0.mod_create_form_ptw')
  dateFileReq = JSON.parse JsonUtil.read_json('ptw/0.mod_create_form_ptw')
  @formNumber = dataFileResp['data']['createForm']['_id']
  @formName = dateFileReq['variables']['permitType']
  sleep(2)
end

Then(/^Then I should see the Section 6 with gas (.+) shows the same fields as in the Client app$/) do |_condition|
  fieldsArr = []
  subheadersArr = []
  $browser.find_elements(:xpath, "//h2[contains(text(),'Section 6')]/../..//h4").each do |_field|
    fieldsArr << _field.text
  end
  $browser.find_elements(:xpath, "//h2[contains(text(),'Section 6')]/../..//h2").each do |_subheader|
    subheadersArr << _subheader.text
  end
  baseFields = [] + YAML.load_file("data/screens-label/Section 6.yml")["fields_#{_condition}"]
  baseSubheaders = [] + YAML.load_file("data/screens-label/Section 6.yml")['subheaders']
  p ">>> difference #{fieldsArr - baseFields}"
  p "> difference #{subheadersArr - baseSubheaders}"
  is_equal(fieldsArr, baseFields)
  is_equal(subheadersArr, baseSubheaders)
end

Then(/^I should see the (.*) shows the same fields as in the Client app with (.*)$/) do |_section, _condition|
  fieldsArr = []
  subheadersArr = []
  $browser.find_elements(:xpath, "//h2[contains(text(),'#{_section}')]/../..//h4").each do |_field|
    fieldsArr << _field.text
  end
  $browser.find_elements(:xpath, "//h2[contains(text(),'#{_section}')]/../..//h2").each do |_subheader|
    subheadersArr << _subheader.text
  end
  baseFields = [] + YAML.load_file("data/screens-label/#{_section}.yml")["fields_#{_condition}"]
  baseSubheaders = [] + YAML.load_file("data/screens-label/#{_section}.yml")["subheaders_#{_condition}"]
  p ">>> difference #{fieldsArr - baseFields}"
  p "> difference #{subheadersArr - baseSubheaders}"
  is_equal(fieldsArr, baseFields)
  is_equal(subheadersArr, baseSubheaders)
end

Then(/^I should see Section 8 shows the same fields as in the Client app with (.*)$/) do |_checklist|
  case _checklist
  when "Critical Equipment Maintenance"
    _checklist = "critical"
  when "Work on Electrical Equipment and Circuits"
    _checklist = "electrical"
  when "Work on Pressure Pipelines"
    _checklist = "pipe"
  end
  fieldsArr = []
  subheadersArr = []
  $browser.find_elements(:xpath, "//h2[contains(text(),'Section 8')]/../..//h4").each do |_field|
    fieldsArr << _field.text
  end
  $browser.find_elements(:xpath, "//h2[contains(text(),'Section 8')]/../..//h2").each do |_subheader|
    subheadersArr << _subheader.text
  end
  baseFields = [] + YAML.load_file("data/screens-label/Section 8.yml")["fields_#{_checklist}"]
  baseSubheaders = [] + YAML.load_file("data/screens-label/Section 8.yml")["subheaders_eic_no"]
  p ">>> difference #{fieldsArr - baseFields}"
  p "> difference #{subheadersArr - baseSubheaders}"
  is_equal(fieldsArr, baseFields)
  is_equal(subheadersArr, baseSubheaders)
end