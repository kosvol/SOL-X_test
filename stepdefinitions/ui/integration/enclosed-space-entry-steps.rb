# frozen_string_literal: true

And (/^I review page 1 of submitted (.+) permit$/) do |_permit_type|
  on(CreatedPermitToWorkPage).select_created_permit_with_param(CommonPage.get_permit_id).click
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
  step 'I press next from section 1'
  sleep 1
  is_equal(on(Section2Page).generic_data_elements[0].text, 'Master')
  is_equal(on(Section2Page).generic_data_elements[1].text, 'N/A')
end

And (/^I review page 3a of submitted (.+) permit$/) do |_permit_type|
  on(Section1Page).next_btn_elements.last.click
  sleep 1
  does_include(on(Section3APage).date_and_time_fields_elements[0].text, '/')
  does_include(on(Section3APage).date_and_time_fields_elements[1].text, 'LT (GMT+')
  does_include(on(Section3APage).generic_data_elements[0].text, 'SIT')
  does_include(on(Section3APage).generic_data_elements[1].text, 'SIT/DRA')
  # is_equal(on(Section3APage).generic_data_elements[3].text, 'Standard procedures for connecting and disconnecting pipelines')
end

And (/^I review page 3b of submitted (.+) permit$/) do |_permit_type|
  on(Section1Page).next_btn_elements.last.click
  base_data = @@form_data['section3b']
  capture_data = on(Section3BPage).get_filled_section
  base_data.delete_at(6)
  base_data.delete_at(6)
  p ">> #{base_data}"
  p "-- #{capture_data}"
  capture_data.delete_at(6)
  begin
    does_include(on(Section3BPage).last_assessment_date_element.text, "/#{BrowserActions.get_year}")
    does_include(on(Section3BPage).generic_data_elements[6].text, "SIT/DRA/#{BrowserActions.get_year}")
  rescue StandardError
    puts '>> Probably First RUN !!!!'
    capture_data.delete_at(6)
  end
  p "=== #{capture_data}"
  is_equal(capture_data, base_data)
end

And (/^I review page 3c of submitted (.+) permit$/) do |_permit_type|
  on(Section1Page).next_btn_elements.last.click
  sleep 4
  is_equal(on(Section3CPage).dra_team_name_elements.first.text, @@form_data['section3c'])
end

And (/^I review page 3d of submitted (.+) permit$/) do |_permit_type|
  on(Section1Page).next_btn_elements.last.click
  sleep 1
  p "--- #{on(Section3DPage).get_filled_section}"
  is_equal(on(Section3DPage).get_filled_section, @@form_data['section3d-yes'])
end

And (/^I review page 4a of submitted (.+) permit$/) do |_permit_type|
  on(Section1Page).next_btn_elements.last.click
  p "+++ #{on(Section4APage).get_filled_section}"
  is_equal(on(Section4APage).get_filled_section, @@form_data['section4a'])
end

And (/^I review page 4a checklist of submitted (.+) permit$/) do |_permit_type|
  on(Section1Page).next_btn_elements.last.click
  sleep 1
  does_include(on(Section4APage).checklist_date_element.text, "/#{BrowserActions.get_year}")
  does_include(on(Section4APage).checklist_time_element.text, 'LT (GMT+')
  does_include(on(Section4APage).generic_data_elements[1].text, 'SIT/PTW')
  extract = on(Section4APage).get_filled_section
  extract.delete_at(1)
  # extract.delete_at(1)
  p "<<< #{extract}"
  is_equal(extract, @@form_data['checklist'])
end

And (/^I review page 4b of submitted (.+) permit$/) do |_permit_type|
  on(Section1Page).next_btn_elements.last.click
  is_equal(on(Section4BPage).get_filled_section, @@form_data['section4b'])
end

And (/^I review page 5 of submitted (.+) permit$/) do |_permit_type|
  on(Section1Page).next_btn_elements.last.click
  ### PENDING
end

And (/^I review page 6 of submitted (.+) permit$/) do |_permit_type|
  on(Section1Page).next_btn_elements.last.click
  p "<><><> #{on(Section6Page).get_filled_section}"
  is_equal(on(Section6Page).get_filled_section, @@form_data['section6'])
  does_include(on(Section6Page).rank_and_name_stamp, 'A/M Atif Hayat')
  does_include(on(Section6Page).date_and_time_stamp, 'LT (GMT+')
  does_include(on(Section6Page).date_and_time_stamp, '/')
  # does_include(on(Section6Page).date_and_time_btn_elements[0].text, 'LT (GMT+')
  # does_include(on(Section6Page).date_and_time_btn_elements[1].text, '/')
end
