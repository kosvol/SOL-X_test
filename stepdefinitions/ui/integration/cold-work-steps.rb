# frozen_string_literal: true

# And (/^I review page 1 of submitted cold work permit$/) do
#   tmp = on(SmartFormsPermissionPage).get_section1_filled_data
#   match_obj = on(CreatedPermitToWorkPage).select_created_permit_with_param(tmp[1])
#   match_obj.click
#   step 'I enter pin 1111'
#   @@form_data = YAML.load_file('data/filled-form-data/cold-work.yml')
#   p ">>> #{on(Section1Page).get_filled_section1}"
#   is_equal(on(Section1Page).get_filled_section1, @@form_data['section1_without_duration'])
# end

And (/^I review page 2 of submitted cold work permit$/) do
  step 'I press next from section 1'
  sleep 1
  is_equal(on(Section2Page).generic_data_elements[0].text, 'Master')
  is_equal(on(Section2Page).generic_data_elements[1].text, 'N/A')
end

And (/^I review page 3a of submitted cold work permit$/) do
  on(Section1Page).next_btn_elements.last.click
  does_include(on(Section3APage).date_and_time_fields_elements[0].text, '/')
  does_include(on(Section3APage).date_and_time_fields_elements[1].text, 'LT (GMT+')
  does_include(on(Section3APage).generic_data_elements[0].text, 'SIT')
  does_include(on(Section3APage).generic_data_elements[1].text, 'SIT/DRA')
  # does_include(on(Section3APage).generic_data_elements[3].text, 'General procedures for Enclosed Space Entry')
end

And (/^I review page 3b of submitted cold work permit$/) do
  on(Section1Page).next_btn_elements.last.click
  is_equal(on(Section3BPage).get_filled_section, @@form_data['section3b'])
end

And (/^I review page 3c of submitted cold work permit$/) do
  on(Section1Page).next_btn_elements.last.click
  sleep 1
  is_equal(on(Section3CPage).dra_team_name, @@form_data['section3c'])
end

And (/^I review page 3d of submitted cold work permit$/) do
  on(Section1Page).next_btn_elements.last.click
  sleep 1
  p "--- #{on(Section3DPage).get_filled_section}"
  is_equal(on(Section3DPage).get_filled_section, @@form_data['section3d-yes'])
end

And (/^I review page 4a of submitted cold work permit$/) do
  on(Section1Page).next_btn_elements.last.click
  p "+++ #{on(Section4APage).get_filled_section}"
  is_equal(on(Section4APage).get_filled_section, @@form_data['section4a'])
end

And (/^I review page 4a checklist of submitted cold work permit$/) do
  on(Section1Page).next_btn_elements.last.click
  does_include(on(Section4APage).checklist_date_and_time_elements[0].text, '/')
  does_include(on(Section4APage).checklist_date_and_time_elements[1].text, 'LT (GMT+')
  does_include(on(Section4APage).checklist_permit_number, 'SIT/PTW')
  extract = on(Section4APage).get_filled_section
  extract.delete_at(1)
  p "<<< #{extract}"
  is_equal(extract, @@form_data['checklist'])
end

And (/^I review page 4b of submitted cold work permit$/) do
  on(Section1Page).next_btn_elements.last.click
  is_equal(on(Section4BPage).get_filled_section, @@form_data['section4b'])
end

And (/^I review page 5 of submitted cold work permit$/) do
  on(Section1Page).next_btn_elements.last.click
  ### PENDING
end

And (/^I review page 6 of submitted cold work permit$/) do
  on(Section1Page).next_btn_elements.last.click
  p "<><><> #{on(Section6Page).get_filled_section}"
  is_equal(on(Section6Page).get_filled_section, @@form_data['section6'])
  does_include(on(Section6Page).rank_and_name_stamp, 'A/M Atif Hayat')
  does_include(on(Section6Page).date_and_time_stamp, 'LT (GMT+')
  does_include(on(Section6Page).date_and_time_stamp, '/')
  # does_include(on(Section6Page).date_and_time_btn_elements[0].text, 'LT (GMT+')
  # does_include(on(Section6Page).date_and_time_btn_elements[1].text, '/')
end
