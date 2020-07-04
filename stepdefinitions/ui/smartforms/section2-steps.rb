# frozen_string_literal: true

Then (/^I should see section 2$/) do
  is_equal(on(Section2Page).heading_text_element.text, 'Section 2: Approving Authority')
end

And (/^I should see previous and next buttons$/) do
  to_exists(on(Section2Page).previous_btn_element)
  to_exists(on(Section2Page).next_btn_element)
end

When (/^I proceed to section 3a$/) do
  sleep 1
  on(Section2Page).next_btn
end

Then (/^I should see correct approval details for non-OA$/) do
  is_equal(on(Section2Page).ship_approval, 'Master')
  is_equal(on(Section2Page).office_approval, 'N/A')
end

Then (/^I should see correct approval details for maintenance duration (more|less) than 2 hours$/) do |_condition|
  is_equal(on(Section2Page).ship_approval, 'Master')
  is_equal(on(Section2Page).office_approval, 'VS') if _condition === 'more'
  is_equal(on(Section2Page).office_approval, 'N/A') if _condition === 'less'
end

Then (/^I should see correct approval details OA (.+) and ship approval (.+)$/) do |oa, sa|
  is_equal(on(Section2Page).ship_approval, sa)
  is_equal(on(Section2Page).office_approval, oa)
end

Then (/^I should see ship and office approval text fields disabled$/) do
  is_true(!is_enabled?(on(Section2Page).ship_approval_element))
  is_true(!is_enabled?(on(Section2Page).office_approval_element))
end

Then (/^I should see display texts match for section2$/) do
  section2_labels_arr = YAML.load_file('data/screen-labels.yml')['default_section2_labels']
  page_elements = on(Section1Page).all_labels_elements
  page_elements.each_with_index do |label, _index|
    is_equal(section1_labels_arr[_index], label.text)
  end
end
