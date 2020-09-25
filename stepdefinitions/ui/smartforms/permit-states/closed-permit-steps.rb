# frozen_string_literal: true

And (/^I terminate the permit$/) do
  on(CreatedPermitToWorkPage).submit_termination_btn1_elements.first.click
  step 'I enter pin 9015'
  on(CreatedPermitToWorkPage).submit_termination_btn_elements.first.click
  step 'I enter pin 9015'
  step 'I sign on canvas'
  step 'I click on back to home'
  step 'I click on pending withdrawal filter'
end

Then (/^I should see termination date display$/) do
end
