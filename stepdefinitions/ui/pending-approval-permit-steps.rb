# frozen_string_literal: true

And (/^I review page 1 of submitted permit$/) do
  on(SmartFormsPermissionPage).master_approval_elements[0].click
  step 'I enter pin 1111'
  # load yml
  p ">>> #{on(Section1Page).get_filled_section1}"
  on(Section1Page).next_btn_elements.first.click
end

And (/^I review page 2 of submitted permit$/) do
  # review
  on(Section1Page).next_btn_elements.last.click
end
