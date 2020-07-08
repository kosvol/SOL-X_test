# frozen_string_literal: true

And (/^I select a any permits$/) do
  sleep 1
  on(SmartFormsPermissionPage).select_random_level1_permit
  on(SmartFormsPermissionPage).select_random_level2_permit
end

Then (/^I should see permit details are pre-filled$/) do
  is_equal(on(SmartFormsPermissionPage).permit_type, on(SmartFormsPermissionPage).get_section1_filled_data[0])
  is_equal(on(SmartFormsPermissionPage).form_number, on(SmartFormsPermissionPage).get_section1_filled_data[1])
  is_equal(on(SmartFormsPermissionPage).vessel_short_name, 'SIT')
end

Then (/^I should see a list of sea states$/) do |_table|
  is_true(on(Section1Page).is_sea_states?(_table.raw))
end

Then (/^I should see a list of wind forces$/) do |_table|
  is_true(on(Section1Page).is_wind_forces?(_table.raw))
end

Then (/^I should not see save and previous button exists$/) do
  is_equal(on(Section1Page).save_and_next_btn_elements.size, 1)
end

Then (/^I (should|should not) see maintenance duration section and require text$/) do |condition|
  if condition === 'should'
    is_true(on(Section1Page).is_maint_duration_dd_exists?)
  end
  if condition === 'should not'
    is_true(!on(Section1Page).is_maint_duration_dd_exists?)
  end
end

# And (/^I select a level 2 permit randomly$/) do
#   on(SmartFormsPermissionPage).get_random_permit.click
#   sleep 1
#   on(SmartFormsPermissionPage).save_btn
# end

And (/^I submit after filling up section 1 with duration (more|less) than 2 hours$/) do |condition|
  sleep 1
  on(Section1Page).fill_all_of_section_1_w_duration(condition)
end

Then (/^I should see display texts match for section1$/) do
  section1_labels_arr = YAML.load_file('data/screen-labels.yml')['default_section1_labels']
  page_elements = on(Section1Page).all_labels_elements
  if page_elements.size === 14
    section1_labels_arr.delete_at(section1_labels_arr.size - 2)
  end
  page_elements.each_with_index do |label, _index|
    is_equal(section1_labels_arr[_index], label.text)
  end
end

And (/^I fill up section 1$/) do
  sleep 1
  permits_arr = YAML.load_file('data/permits.yml')['Critical Equipment Maintenance']
  if permits_arr.include? on(SmartFormsPermissionPage).get_selected_level2_permit
    on(Section1Page).fill_all_of_section_1_w_duration(%w[more less].sample)
  else
    on(Section1Page).fill_all_of_section_1_wo_duration
  end
end
