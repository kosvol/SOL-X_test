# frozen_string_literal: true

And(/^I fill zone details$/) do
  on(Section1Page).fill_partial_section_1
end

Then(/^I should see navigation dropdown$/) do
  to_exists(on(Section1Page).s1_navigation_dropdown_element)
end

Then(/^I should see permit details are pre-filled$/) do
  Log.instance.info "#{on(Section1Page).get_section1_filled_data}"
  is_equal(on(Section1Page).generic_data_elements[1].text, on(Section1Page).get_section1_filled_data[0])
  is_equal(on(Section1Page).generic_data_elements[0].text, 'SOLX Automation Test')
end

Then(/^I should see a list of (sea states|wind forces)$/) do |_state, _table|
  is_true(on(Section1Page).is_sea_states?(_table.raw)) if _state === 'sea states'
  is_true(on(Section1Page).is_wind_forces?(_table.raw)) if _state === 'wind forces'
end

Then(/^I should not see previous button exists$/) do
  on(Section3APage).scroll_multiple_times(10)
  is_equal(on(Section1Page).btn_list_elements[0].text, 'Save & Next')
end

Then(/^I (should|should not) see maintenance duration section and require text$/) do |_condition|
  if _condition === 'should'
    is_true(on(Section1Page).is_maint_duration_dd_exists?)
  elsif _condition === 'should not'
    is_true(!on(Section1Page).is_maint_duration_dd_exists?)
  end
end

And(/^I fill section 1 of maintenance permit with duration (more|less) than 2 hours$/) do |_condition|
  on(Section1Page).fill_default_section_1
  on(Section1Page).set_maintenance_duration(_condition)
  sleep 1
end

And(/^I should not see copy text regarding maintenance hour$/) do
  not_to_exists(on(Section2Page).maintenance_text_element)
end

And(/^I fill up section 1 with default value$/) do
  permits_arr = YAML.load_file('data/permit-types.yml')['Critical Equipment Maintenance']
  on(Section1Page).fill_default_section_1
  Log.instance.info "Permit: #{on(Section0Page).get_section1_filled_data.last}"
  if permits_arr.include? on(Section0Page).get_section1_filled_data.last
    on(Section1Page).set_maintenance_duration(%w[more less].sample)
  end
end

And(/^I fill only location of work and duration (more|less) than 2 hours$/) do |_condition|
  on(Section1Page).select_location_of_work
  on(Section1Page).set_maintenance_duration(_condition)
end

And(/^I fill only location of work$/) do
  on(Section1Page).select_location_of_work
end
