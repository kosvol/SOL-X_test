# frozen_string_literal: true

And(/^I request terminating permit to be updated with (.*) rank$/) do |_rank|
  BrowserActions.poll_exists_and_click(on(PendingWithdrawalPage).review_n_withdraw_elements.first)
  step "I enter pin for rank #{_rank}"
end

And(/^I terminate the permit with (.*) rank via Pending Withdrawal$/) do |_rank|
  BrowserActions.poll_exists_and_click(on(PendingWithdrawalPage).review_n_withdraw_elements.first)
  step "I enter pin for rank #{_rank}"
  on(Section9Page).submit_permit_termination_btn
  step "I sign with valid #{_rank} rank"
  step 'I click on back to home'
end

Then(/^I should see termination date display$/) do
  # step 'I set time'
  p on(CommonFormsPage).get_current_date_and_time.to_s
  p on(CommonFormsPage).get_current_date_and_time_add_a_min.to_s
  if on(CommonFormsPage).get_current_date_and_time.to_s === on(ClosedStatePage).terminated_date_time_elements[0].text
    is_equal(on(CommonFormsPage).get_current_date_and_time.to_s,
             on(ClosedStatePage).terminated_date_time_elements[0].text)
  else
    is_equal(on(CommonFormsPage).get_current_date_and_time_minus_a_min.to_s,
             on(ClosedStatePage).terminated_date_time_elements[0].text)
  end
end

And(/^I should be able to view close permit$/) do
  on(ActiveStatePage).view_btn_elements.first.click
  step 'I enter pin for rank MAS'
  is_equal(on(Section1Page).generic_data_elements[0].text, EnvironmentSelector.get_vessel_name)
end
