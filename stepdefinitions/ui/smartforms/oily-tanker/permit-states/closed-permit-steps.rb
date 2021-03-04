# frozen_string_literal: true

And (/^I request terminating permit to be updated$/) do
  # sleep 1
  BrowserActions.poll_exists_and_click(on(CommonFormsPage).review_and_terminate_btn_elements.first)
  # on(CommonFormsPage).review_and_terminate_btn_elements.first.click
  step 'I enter pin 1111'
end

And (/^I terminate the permit with (.*) pin$/) do |_pin|
  BrowserActions.poll_exists_and_click(on(CommonFormsPage).review_and_terminate_btn_elements.first)
  step "I enter pin #{_pin}"
  on(Section9Page).submit_permit_termination_btn
  step "I sign on canvas with valid #{_pin} pin"
  sleep 2
  on(CommonFormsPage).close_btn_elements.first.click
  sleep 4
  step 'I set permit id'
end

Then (/^I should see termination date display$/) do
  # step 'I set time'
  p "#{on(CommonFormsPage).get_current_date_and_time.to_s}"
  p "#{on(CommonFormsPage).get_current_date_and_time_add_a_min.to_s}"
  begin
    is_equal(on(CommonFormsPage).get_current_date_and_time.to_s, on(ClosedStatePage).terminated_date_time_elements[0].text)
  rescue
    is_equal(on(CommonFormsPage).get_current_date_and_time_add_a_min.to_s, on(ClosedStatePage).terminated_date_time_elements[0].text)
  end
end

And (/^I should be able to view close permit$/) do
  on(ActiveStatePage).view_btn_elements.first.click
  step 'I enter pin 1111'
  is_equal(on(Section1Page).generic_data_elements[0].text, 'SOLX Automation Test')
end
