# frozen_string_literal: true

Then (/^I should see extra section8 questions for pipe permit$/) do
  on(Section8Page).normalization_pipe_question1
  on(Section8Page).normalization_pipe_question2
  is_equal($browser.find_elements(:xpath, '//input').size, '23')
end

Then (/^I should see extra section8 questions for critical maintenance permit$/) do
  on(Section8Page).normalization_crit_question1
  on(Section8Page).normalization_crit_question2
  on(Section8Page).normalization_crit_question3
  is_equal($browser.find_elements(:xpath, '//input').size, '26')
end

Then (/^I should see extra section8 questions for electrical permit$/) do
  on(Section8Page).normalization_elec_question1
  on(Section8Page).normalization_elec_question2
  is_equal($browser.find_elements(:xpath, '//input').size, '23')
end

And (/^I should see (.+) rank and name for section 8$/) do |_rank|
  BrowserActions.scroll_down
  sleep 3
  is_equal(on(Section8Page).rank_name_and_date_elements.last.text,on(Section8Page).get_signed_date_time)
  is_equal(on(Section8Page).rank_name_and_date_elements.first.text, _rank)
end

And (/^I should see signed date and time for section 8$/) do
  is_equal(on(Section8Page).rank_name_and_date_elements.last.text, on(Section8Page).get_signed_date_time)
end

Then (/^I (should|should not) see EIC normalize extra questions$/) do |_condition|
  sleep 1
  if _condition === 'should'
    is_equal($browser.find_elements(:xpath, '//input').size, '27')
    on(Section8Page).normalization_question1
    on(Section8Page).normalization_question2
    on(Section8Page).normalization_question3
    on(Section8Page).normalization_question4
    on(Section8Page).normalization_question5
  end
  if _condition === 'should not'
    is_equal($browser.find_elements(:xpath, '//input').size, '17')
  end
end

Then (/^I should see EIC extra questions for work on pressure pipe permit$/) do
  on(Section8Page).normalization_pipe_question1
  on(Section8Page).normalization_pipe_question2
  is_equal($browser.find_elements(:xpath, '//input').size, '21')
end

And (/^I sign EIC section 8 with RA (.+)$/) do |_pin|
  on(Section3APage).scroll_multiple_times(4)
  on(Section8Page).submit_termination_btn_elements.first.click
  @@entered_pin = _pin.to_i
  on(PinPadPage).enter_pin(@@entered_pin)
  step 'I sign on canvas'
  sleep 1
  step 'I click on back to home'
end

And (/^I manually put the permit to pending termination state$/) do
  sleep 1
  on(Section0Page).submit_termination_btn1_elements.first.click
  on(PinPadPage).enter_pin("9015")
  sleep 1
  on(Section8Page).task_status_completed_element.click
  step 'I sign EIC section 8 with RA 9015'
end