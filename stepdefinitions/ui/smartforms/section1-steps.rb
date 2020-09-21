# frozen_string_literal: true

Then (/^I should see permit details are pre-filled$/) do
  is_equal(on(Section1Page).generic_data_elements[2].text, on(Section1Page).get_section1_filled_data[0])
  is_equal(on(Section1Page).generic_data_elements[1].text, on(Section1Page).get_section1_filled_data[1])
  is_equal(on(Section1Page).generic_data_elements[0].text, 'SIT')
end

Then (/^I should see a list of sea states$/) do |_table|
  is_true(on(Section1Page).is_sea_states?(_table.raw))
end

Then (/^I should see a list of wind forces$/) do |_table|
  is_true(on(Section1Page).is_wind_forces?(_table.raw))
end

Then (/^I should not see previous button exists$/) do
  is_equal(on(Section1Page).btn_list_elements[0].text, 'Save & Next')
end

Then (/^I (should|should not) see maintenance duration section and require text$/) do |condition|
  if condition === 'should'
    is_true(on(Section1Page).is_maint_duration_dd_exists?)
  elsif condition === 'should not'
    is_true(!on(Section1Page).is_maint_duration_dd_exists?)
  end
end

And (/^I submit after filling up section 1 with duration (more|less) than 2 hours$/) do |condition|
  on(Section1Page).fill_default_section_1
  step "I set maintenance during #{condition} than 2 hours"
end

And (/^I set maintenance during (more|less) than 2 hours$/) do |condition|
  on(Section1Page).set_maintenance_duration(condition)
end

And (/^I should not see copy text regarding maintenance hour$/) do
  not_to_exists(on(Section2Page).maintenance_text_element)
end

And (/^I fill up section 1 with default value$/) do
  permits_arr = YAML.load_file('data/permits.yml')['Critical Equipment Maintenance']
  on(Section1Page).fill_default_section_1
  if permits_arr.include? on(Section0Page).get_selected_level2_permit
    on(Section1Page).set_maintenance_duration(%w[more less].sample)
  end
end
