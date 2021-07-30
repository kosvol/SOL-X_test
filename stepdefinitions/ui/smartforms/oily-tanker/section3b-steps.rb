# frozen_string_literal: true

And(/^I fill up section 3b$/) do
  on(Section3BPage).fill_section_3b
end

Then(/^I should see method description (.+) populated$/) do |method_desc|
  is_equal(on(Section3BPage).method_detail_elements.first.text, method_desc)
end

Then(/^I should see dra number and last assessment date populated$/) do
  p "permit id: #{CommonPage.get_dra_permit_id}"
  is_equal(on(Section3BPage).last_assessment, CommonPage.get_dra_permit_id)
  is_equal(on(Section3BPage).last_assessment_date_element.text, on(CommonFormsPage).get_current_date_format_with_offset)
end

Then(/^I should see By: Master after clicking Yes on Is DRA sent to office$/) do
  on(Section3BPage).radio_btn_elements[6].click
  BrowserActions.scroll_down
  is_equal(on(Section3BPage).generic_data_elements[1].text, 'Master')
  is_equal(on(Section3BPage).generic_data_elements.size, 2)
end

Then(/^I should not see By: Master after clicking No on Is DRA sent to office$/) do
  on(Section3BPage).radio_btn_elements[7].click
  is_equal(on(Section3BPage).generic_data_elements.size, 1)
end

Then(/^I should see crew drop down list after clicking Yes on Inspection carried out$/) do
  on(Section3BPage).radio_btn_elements[0].click
  to_exists(on(Section3BPage).work_side_inspected_by_element)
end

Then(/^I should not see crew drop down list after clicking No on Inspection carried out$/) do
  on(Section3BPage).radio_btn_elements[1].click
  not_to_exists(on(Section3BPage).work_side_inspected_by_element)
end

And(/^I should see crew list populated$/) do
  is_true(on(Section3BPage).crew_list_populated?)
end

Then(/^I should see work site inspected by crew member list display all crews$/) do
  on(Section3BPage).radio_btn_elements.first.click
  on(Section3BPage).work_side_inspected_by
  sleep 1
  is_true(on(Section3BPage).last_crew?)
end
