# frozen_string_literal: true

And (/^I terminate the permit$/) do
  sleep 1
  on(CommonFormsPage).review_and_terminate_btn_elements.first.click
  step 'I enter pin 1111'
  on(Section9Page).submit_permit_termination_btn
  step 'I enter pin 1111'
  step 'I sign on canvas'
  step 'I click on back to home'
end

Then (/^I should see termination date display$/) do
end
