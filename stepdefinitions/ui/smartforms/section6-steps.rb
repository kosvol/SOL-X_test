# frozen_string_literal: true

And (/^I navigate to section (.+)$/) do |_which_section|
  on(Section6Page).toggle_to_section(on(SmartFormsPermissionPage).get_selected_level2_permit, _which_section)
end

Then (/^I should see master review button only$/) do
  is_equal(on(Section6Page).submit_btn_elements.size, '1')
  BrowserActions.scroll_down
  sleep 1
  BrowserActions.scroll_down
  is_equal(on(Section6Page).submit_btn_elements.first.text, "Submit for Master's Review")
end

Then (/^I should see master approval button only$/) do
  BrowserActions.scroll_down
  sleep 1
  BrowserActions.scroll_down
  BrowserActions.scroll_down
  is_equal(on(Section6Page).submit_btn_elements.size, '1')
  is_equal(on(Section6Page).submit_btn_elements.first.text, "Submit for Master's Approval")
end

Then (/^I (should|should not) see gas reader sections$/) do |_condition|
  sleep 1
  on(Section1Page).next_btn_elements.first.click
  sleep 1
  step 'I press next for 9 times'
  is_true(on(Section6Page).is_gas_reader_section?) if _condition === 'should'
  if _condition === 'should not'
    is_true(!on(Section6Page).is_gas_reader_section?)
  end
end

Then (/^I submit permit for Master Approval$/) do
  on(Section6Page).submit_btn_elements[0].click
  step 'I enter pin 1212'
  on(Section3DPage).sign
end
