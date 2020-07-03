# frozen_string_literal: true

And (/^I navigate to section (.+)$/) do |_which_section|
  on(Section6Page).toggle_to_section(on(SmartFormsPermissionPage).get_selected_level2_permit, _which_section)
end

Then (/^I should see master review button only$/) do
  is_equal(on(Section6Page).submit_btn_elements.size, '1')
  is_equal(on(Section6Page).submit_btn_elements.first.text, "Submit for Master's Review")
end
