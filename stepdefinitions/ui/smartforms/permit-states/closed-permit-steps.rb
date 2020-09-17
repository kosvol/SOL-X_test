# frozen_string_literal: true

And (/^I terminate the permit$/) do
  # tmp = on(Section1Page).get_section1_filled_data
  # on(CreatedPermitToWorkPage).delete_permit_btn_elements[on(CreatedPermitToWorkPage).get_permit_index(tmp[1])].click
  on(CreatedPermitToWorkPage).submit_termination_btn_elements.first.click
  step 'I enter pin 9015'
  step 'I press next for 2 times'
  on(CreatedPermitToWorkPage).submit_termination_btn_elements.first.click
  # on(Section6Page).submit_btn_elements.first.click
  step 'I enter pin 1111'
  step 'I sign on canvas'
  step 'I click on back to home'
  step 'I click on pending withdrawal'
end

Then (/^I should see termination date display$/) do
end
