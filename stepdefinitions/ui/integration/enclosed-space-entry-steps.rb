# frozen_string_literal: true

And (/^I review page 1 of submitted (.+) permit$/) do |_permit_type|
  on(CreatedPermitToWorkPage).edit_permit_btn_elements[on(CreatedPermitToWorkPage).get_permit_index(CommonPage.get_permit_id)].click
  # on(CreatedPermitToWorkPage).select_created_permit_with_param(CommonPage.get_permit_id).click
  step 'I enter pin 1111'
  if _permit_type === 'enclose workspace'
    @@form_data = YAML.load_file('data/filled-form-data/enclosed-entry-permit.yml')
  elsif _permit_type === 'hot work'
    @@form_data = YAML.load_file('data/filled-form-data/hot-work.yml')
  elsif _permit_type === 'cold work'
    @@form_data = YAML.load_file('data/filled-form-data/cold-work.yml')
  elsif _permit_type === 'hot work with hazard'
    @@form_data = YAML.load_file('data/filled-form-data/hot-work-hazardous.yml')
  end
  p ">>> #{on(Section1Page).get_filled_section1}"
  is_equal(on(Section1Page).get_filled_section1, @@form_data['section1_without_duration'])
end

And (/^I review page 2 of submitted (.+) permit$/) do |_permit_type|
  step 'I press next for 1 times'
  sleep 1
  is_equal(on(Section2Page).generic_data_elements[0].text, 'Master')
  is_equal(on(Section2Page).generic_data_elements[1].text, 'N/A')
end

And (/^I review page 3a of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  sleep 1
  does_include(on(Section3APage).method_detail_elements[0].text, 'SIT')
  does_include(on(Section3APage).method_detail_elements[1].text, "SIT/DRA/#{BrowserActions.get_year}")
  does_include(on(Section3APage).date_and_time_fields_elements[0].text, on(CommonFormsPage).get_current_date_format_with_offset)
  does_include(on(Section3APage).date_and_time_fields_elements[1].text, ' LT (GMT')
  # does_include(on(Section3APage).date_and_time_fields_elements[1].text, on(CommonFormsPage).get_current_time_format)
  does_include(on(Section3APage).method_detail_elements[2].text, 'Enclosed Space Entry')
  # is_equal(on(Section3APage).generic_data_elements[3].text, 'Standard procedures for connecting and disconnecting pipelines')
  BrowserActions.scroll_click(on(Section3APage).view_edit_btn_element)
  is_true(on(Section3APage).is_new_hazard_added?)
  on(Section3APage).close_btn_elements.first.click
end

And (/^I review page 3b of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  base_data = @@form_data['section3b']
  capture_data = on(Section3BPage).get_filled_section
  base_data.delete_at(6)
  base_data.delete_at(6)
  p ">> #{base_data}"
  p "-- #{capture_data}"
  capture_data.delete_at(6)
  does_include(on(Section3BPage).last_assessment_date_element.text, on(CommonFormsPage).get_current_date_format_with_offset)
  begin
    # does_include(on(Section3BPage).generic_data_elements[6].text, "SIT/DRA/#{BrowserActions.get_year}")
    does_include(on(Section3BPage).generic_data_elements[6].text, "Test automation")
  rescue StandardError
    puts '>> Probably First RUN !!!!'
    # does_include(on(Section3BPage).last_assessment_date_element.text, CommonFormsPage.get_current_date_format_with_offset)
    does_include(on(Section3BPage).generic_data_elements[6].text, "Test automation")
    # capture_data.delete_at(6)
  end
  p "=== #{capture_data}"
  is_equal(capture_data, base_data)
  is_equal(on(Section3BPage).get_inspection_by_element.text,"MAS Daniel Alcantara")
end

And (/^I review page 3c of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  sleep 2
  is_equal(on(Section3CPage).master_element.text, @@form_data['section3c'][0])
  is_equal(on(Section3CPage).am_element.text, @@form_data['section3c'][1])
end

And (/^I review page 3d of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  sleep 1
  p "--- #{on(Section3DPage).get_filled_section}"
  is_equal(on(Section3DPage).get_filled_section, @@form_data['section3d-yes'])
  step 'I should map to partial sign details'
end

And (/^I review page 4a of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  p "+++ #{on(Section4APage).get_filled_section}"
  is_equal(on(Section4APage).get_filled_section, @@form_data['section4a'])
end

And (/^I review page 4a checklist of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  sleep 1
  does_include(on(Section4APage).checklist_date_element.text, "/#{BrowserActions.get_year}")
  does_include(on(Section4APage).checklist_time_element.text, 'LT (GMT')
  does_include(on(Section4APage).generic_data_elements[1].text, 'SIT/PTW')
  extract = on(Section4APage).get_filled_section
  extract.delete_at(1)
  p "<<< #{extract}"
  is_equal(extract, @@form_data['checklist'])
  is_equal(@browser.find_element(:xpath, '//input').attribute('value').to_s, '1')
  step 'I should map to partial sign details'
end

And (/^I review page 4b of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  is_equal(on(Section4BPage).get_filled_section, @@form_data['section4b'])
  sleep 1
  on(Section4BPage).view_eic_btn
  sleep 1
  tmp = on(Section4BPage).get_filled_section
  tmp.delete_at(1)
  tmp.delete_at(3)
  p "++ #{@@form_data['section4b_eic']}"
  p "-- #{tmp}"
  is_equal(tmp, @@form_data['section4b_eic'])
  step 'I set time'
  step 'I should see signed details'
  on(CommonFormsPage).close_btn_elements.first.click
  sleep 1
  step 'I set time'
  step 'I should see signed details'
end

And (/^I review page 5 of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  is_equal(on(Section5Page).get_filled_roles_responsibility_elements.first.text, "Authorized Entrant 1")
  is_equal(on(Section5Page).get_filled_crew_details_elements[0].text, "C/O Alister Leong")
  is_equal(on(Section5Page).get_filled_crew_details_elements[1].text, "Test Automation")
  does_include(on(Section5Page).get_filled_crew_details_elements[2].text, on(CommonFormsPage).get_current_date_format_with_offset)
  does_include(on(Section5Page).get_filled_crew_details_elements[2].text, " LT (GMT")
  is_equal(on(Section5Page).get_filled_crew_details_elements[3].text, "Test Automation Company")
end

And (/^I review page 6 of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  p "<><><> #{on(Section6Page).get_filled_section}"
  is_equal(on(Section6Page).get_filled_section, @@form_data['section6'])
  is_equal(on(Section6Page).date_and_time_btn_elements.first.text,on(CommonFormsPage).get_current_date_format_with_offset)
  does_include(on(Section6Page).rank_and_name_stamp, 'A/M Atif Hayat')
  does_include(on(Section6Page).date_and_time_stamp, 'LT (GMT')
  does_include(on(Section6Page).date_and_time_stamp, '/')
  step 'I should see gas reading display with toxic gas'
  # does_include(on(Section6Page).date_and_time_btn_elements[0].text, 'LT (GMT')
  # does_include(on(Section6Page).date_and_time_btn_elements[1].text, '/')
end
