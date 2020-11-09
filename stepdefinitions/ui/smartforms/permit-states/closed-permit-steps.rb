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
  step 'I set time'
  is_equal(on(CommonFormsPage).get_current_date_and_time.to_s, on(ClosedStatePage).terminated_date_time_elements[0].text)
end

And (/^I should be able to view close permit$/) do
  on(ActiveStatePage).view_btn_elements.first.click
  step 'I enter pin 1111'
  is_equal(on(Section1Page).generic_data_elements[0].text, 'SIT')
end
