# frozen_string_literal: true

And(/^I should see previous and next buttons$/) do
  is_equal(on(Section2Page).previous_btn_elements.size, 1)
  to_exists(on(Section2Page).previous_btn_elements.first)
  to_exists(on(Section2Page).next_btn_element)
end

And(/^I should see previous and close buttons$/) do
  on(Section3APage).scroll_multiple_times_with_direction(5,'down')
  is_equal(on(Section2Page).previous_btn_elements.size, 1)
  to_exists(on(Section2Page).previous_btn_elements.first)
  # to_exists(on(Section2Page).close_btn_elements.first)
  # to_exists(on(Section2Page).save_btn_element)
end

And(/^I should see previous and not close buttons$/) do
  on(Section3APage).scroll_multiple_times_with_direction(5,'down')
  is_equal(on(Section2Page).previous_btn_elements.size, 1)
  to_exists(on(Section2Page).previous_btn_elements.first)
  is_equal(on(Section2Page).close_btn_elements.size, 0)
  # not_to_exists(on(Section2Page).close_btn_elements.first)
  # to_exists(on(Section2Page).save_btn_element)
end

Then(/^I should see correct approval details for non-OA$/) do
  is_equal(on(Section2Page).generic_data_elements[0].text, 'Master')
  is_equal(on(Section2Page).generic_data_elements[1].text, 'N/A')
end

Then(/^I should see correct approval details for maintenance duration (more|less) than 2 hours$/) do |_condition|
  is_equal(on(Section2Page).generic_data_elements[0].text, 'Master')
  is_equal(on(Section2Page).generic_data_elements[1].text, 'VS') if _condition === 'more'
  is_equal(on(Section2Page).generic_data_elements[1].text, 'N/A') if _condition === 'less'
end

Then(/^I should see correct approval details OA (.+) and ship approval (.+)$/) do |oa, sa|
  is_equal(on(Section2Page).generic_data_elements[0].text, sa)
  is_equal(on(Section2Page).generic_data_elements[1].text, oa)
end

Then(/^I should see ship and office approval text fields disabled$/) do
  is_disabled(on(Section2Page).generic_data_elements[0])
  is_disabled(on(Section2Page).generic_data_elements[1])
end

Then(/^I should see display texts match for section2$/) do
  section2_labels_arr = YAML.load_file('data/screens-label/screen-labels.yml')['default_section2_labels']
  page_elements = on(Section1Page).all_labels_elements
  page_elements.each_with_index do |label, _index|
    is_equal(section2_labels_arr[_index], label.text)
  end
end
