# frozen_string_literal: true

And(/^I review page 1 of submitted (.+) permit$/) do |_permit_type|
  # step 'I click on permit for Master Approval'
  on(PendingStatePage).pending_approval_status_btn_elements[0].click

  step 'I enter pin for rank MAS'
  if _permit_type === 'enclose workspace'
    @@form_data = YAML.load_file('data/filled-forms-base-data/enclosed-entry-permit.yml')
  elsif _permit_type === 'hot work'
    @@form_data = YAML.load_file('data/filled-forms-base-data/hot-work.yml')
  elsif _permit_type === 'cold work'
    @@form_data = YAML.load_file('data/filled-forms-base-data/cold-work.yml')
  elsif _permit_type === 'hot work with hazard'
    @@form_data = YAML.load_file('data/filled-forms-base-data/hot-work-hazardous.yml')
  end
  p ">>> #{on(Section1Page).get_filled_section1}"
  is_equal(on(Section1Page).get_filled_section1, @@form_data['section1_without_duration'])
  # step 'I press next for 2 times'
end

And(/^I review page 2 of submitted (.+) permit$/) do |_permit_type|
  step 'I press next for 1 times'
  sleep 1
  is_equal(on(Section2Page).generic_data_elements[0].text, @@form_data['section2'][0])
  is_equal(on(Section2Page).generic_data_elements[1].text, @@form_data['section2'][1])
end

And(/^I review page 3a of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  sleep 1
  does_include(on(Section3APage).method_detail_elements[0].text, 'SOLX Automation Test')
  does_include(on(Section3APage).method_detail_elements[1].text, "AUTO/DRA/#{BrowserActions.get_year}")
  does_include(on(Section3APage).method_detail_elements[2].text,
               on(CommonFormsPage).get_current_date_format_with_offset)
  does_include(on(Section3APage).method_detail_elements[2].text, ' LT (GMT')
  # does_include(on(Section3APage).date_and_time_fields_elements[0].text, on(CommonFormsPage).get_current_date_format_with_offset)
  # does_include(on(Section3APage).date_and_time_fields_elements[1].text, ' LT (GMT')
  does_include(on(Section3APage).method_detail_elements[3].text, 'Enclosed Space Entry')
  # is_equal(on(Section3APage).generic_data_elements[3].text, 'Standard procedures for connecting and disconnecting pipelines')
  BrowserActions.scroll_click(on(Section3APage).view_edit_btn_element)
  is_true(on(Section3APage).is_new_hazard_added?)
  on(Section3APage).close_btn_elements.first.click
end

And(/^I review page 3b of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  base_data = @@form_data['section3b']
  capture_data = on(Section3BPage).get_filled_section
  base_data.delete_at(7)
  base_data.delete_at(7)
  p ">> #{base_data}"
  p "-- #{capture_data}"
  capture_data.delete_at(7)
  capture_data.delete_at(7)
  # does_include(on(Section3BPage).method_detail_elements[6].text, on(CommonFormsPage).get_current_date_format_with_offset)
  begin
    # does_include(on(Section3BPage).generic_data_elements[6].text, "SIT/DRA/#{BrowserActions.get_year}")
    does_include(on(Section3BPage).method_detail_elements[7].text, 'Test automation')
  rescue StandardError
    puts '>> Probably First RUN !!!!'
    # does_include(on(Section3BPage).last_assessment_date_element.text, CommonFormsPage.get_current_date_format_with_offset)
    does_include(on(Section3BPage).method_detail_elements[7].text, 'Test automation')
    # capture_data.delete_at(6)
  end
  p "=== #{capture_data}"
  is_equal(capture_data, base_data)
  # is_equal(on(Section3BPage).get_inspection_by_element.text,"MAS Daniel Alcantara")
end

And(/^I review page 3c of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  sleep 2
  is_equal(on(Section3CPage).master_element.text, @@form_data['section3c'][0])
  is_equal(on(Section3CPage).am_element.text, @@form_data['section3c'][1])
end

And(/^I review page 3d of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  sleep 1
  p "--- #{on(Section3DPage).get_filled_section}"
  is_equal(on(Section3DPage).get_filled_section, @@form_data['section3d-yes'])
  CommonPage.set_entered_pin = '9015'
  step 'I should see signed details for integration test'
  # step 'I should map to partial sign details'
end

And(/^I review page 4a of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  p "+++ #{on(Section4APage).get_filled_section}"
  is_equal(on(Section4APage).get_filled_section, @@form_data['section4a'])
end

And(/^I review page 4a checklist of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  sleep 1
  does_include(on(Section4APage).generic_data_elements[1].text, "/#{BrowserActions.get_year}")
  does_include(on(Section4APage).generic_data_elements[1].text, 'LT (GMT')
  # does_include(on(Section4APage).generic_data_elements[1].text, "#{$current_environment.upcase}/PTW")
  extract = on(Section4APage).get_filled_section
  p "--- #{extract}"
  extract.delete_at(1)
  p "<<< #{extract}"
  is_equal(extract, @@form_data['checklist'])
  CommonPage.set_entered_pin = '9015'
  # is_equal(@browser.find_element(:xpath, '//input').attribute('value').to_s, '1')
  step 'I should see signed details for integration test'
end

And(/^I review page 4b of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  step 'I click on view EIC certification button'
  sleep 1
  tmp = on(Section4BPage).get_filled_section
  tmp.delete_at(1)
  tmp.delete_at(1)
  # tmp.delete_at(3)
  p "++ #{@@form_data['section4b_eic']}"
  p "-- #{tmp}"
  does_include(on(Section4APage).generic_data_elements[1].text, "/#{BrowserActions.get_year}")
  does_include(on(Section4APage).generic_data_elements[1].text, 'LT (GMT')
  does_include(on(Section4APage).generic_data_elements[2].text, 'AUTO/EIC')
  is_equal(tmp, @@form_data['section4b_eic'])
  CommonPage.set_entered_pin = '8383'
  step 'I should see signed details for integration test'
  on(CommonFormsPage).close_btn_elements.first.click
  sleep 1
  CommonPage.set_entered_pin = '9015'
  step 'I should see signed details for integration test'
end

And(/^I review page 5 of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  sleep 1
  is_equal(on(Section5Page).get_filled_roles_responsibility_elements.first.text, 'Authorized Entrant 1')
  p ">>> #{on(Section5Page).get_filled_crew_details_elements[0].text}"
  is_equal(on(Section5Page).get_filled_crew_details_elements[0].text, 'C/O COT C/O')
  is_equal(on(Section5Page).get_filled_crew_details_elements[1].text, 'Test Automation')

  does_include(on(Section5Page).get_non_crew_date_time_element.text,
               on(CommonFormsPage).get_current_date_format_with_offset)
  does_include(on(Section5Page).get_non_crew_date_time_element.text, ' LT (GMT')
  is_equal(on(Section5Page).get_filled_crew_details_elements.last.text, 'Test Automation Company')
end

And(/^I review page 6 of submitted (.+) permit$/) do |_permit_type|
  on(Section0Page).click_next
  tmp = on(Section6Page).get_filled_section
  tmp.delete_at(3)
  p "<><><> #{tmp}"
  is_equal(tmp, @@form_data['section6'])
  is_equal(on(Section4APage).generic_data_elements.last.text, on(CommonFormsPage).get_current_date_format_with_offset)
  does_include(on(Section6Page).rank_and_name_stamp_elements.first.text, 'A/M COT A/M')
  does_include(on(Section6Page).date_and_time_stamp_element.text, 'LT (GMT')
  does_include(on(Section6Page).date_and_time_stamp_element.text, "/#{BrowserActions.get_year}")
  step 'I should see gas reading display with toxic gas and A/M COT A/M rank and name'
end

Then(/^I should see signed details for integration test$/) do
  on(Section4APage).signature_scroll
  is_true(on(Section4APage).is_signed_user_details_integration?(CommonPage.get_entered_pin))
  is_true(on(SignaturePage).is_signature_pad?)
end
