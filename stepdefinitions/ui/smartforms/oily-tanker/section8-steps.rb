# frozen_string_literal: true

Then(/^I should not see issuing and competence authority button$/) do
  sleep 1
  is_equal(on(Section5Page).sign_btn_role_elements.size, 0)
end

Then(/^I should see section 8 in read only mode$/) do
  is_equal(on(Section3APage).total_p_elements.size, 20)
end

Then(/^I should see section 8 editable$/) do
  step 'I should see first 28 input fields else 26 input fields'
  # is_equal($browser.find_elements(:xpath, '//input').size, '28')
end

Then(/^I should see extra section8 questions for pipe permit$/) do
  to_exists(on(Section8Page).normalization_pipe_question1_element)
  to_exists(on(Section8Page).normalization_pipe_question2_element)
  step 'I should see default section 8 questions'
  tmp = $browser.find_elements(:xpath, '//div/span')
  @@section8_questions = YAML.load_file('data/section8.yml')
  tmp.each do |_elem|
    does_include(@@section8_questions['pipe'], _elem.text)
  end
  # input_fields = $browser.find_elements(:xpath, '//input').size
  # if input_fields === 32
  #   is_equal(input_fields, '32')
  # elsif input_fields === 30
  #   is_equal(input_fields, '30')
  # end
  step 'I should see first 32 input fields else 30 input fields'
end

Then(/^I should see extra section8 questions for critical maintenance permit$/) do
  to_exists(on(Section8Page).normalization_crit_question1_element)
  to_exists(on(Section8Page).normalization_crit_question2_element)
  to_exists(on(Section8Page).normalization_crit_question3_element)
  step 'I should see default section 8 questions'
  tmp = $browser.find_elements(:xpath, '//div/span')
  @@section8_questions = YAML.load_file('data/section8.yml')
  tmp.each do |_elem|
    does_include(@@section8_questions['critical'], _elem.text)
  end
  # input_fields = $browser.find_elements(:xpath, '//input').size
  # if input_fields === 37
  #   is_equal(input_fields, '37')
  # elsif input_fields === 35
  #   is_equal(input_fields, '35')
  # end
  step 'I should see first 37 input fields else 35 input fields'
end

Then(/^I should see extra section8 questions for electrical permit$/) do
  to_exists(on(Section8Page).normalization_elec_question1_element)
  to_exists(on(Section8Page).normalization_elec_question2_element)
  step 'I should see default section 8 questions'
  tmp = $browser.find_elements(:xpath, '//div/span')
  @@section8_questions = YAML.load_file('data/section8.yml')
  tmp.each do |_elem|
    does_include(@@section8_questions['electrical'], _elem.text)
  end
  # input_fields = $browser.find_elements(:xpath, '//input').size
  # if input_fields === 34
  #   is_equal(input_fields, '34')
  # elsif input_fields === 32
  #   is_equal(input_fields, '32')
  # end
  step 'I should see first 34 input fields else 32 input fields'
end

And('I should see first {int} input fields else {int} input fields') do |first_input_fields_length, second_input_fields_length|
  input_fields = $browser.find_elements(:xpath, '//input').size
  if input_fields === first_input_fields_length
    is_equal(input_fields, first_input_fields_length)
  elsif input_fields === second_input_fields_length
    is_equal(input_fields, second_input_fields_length)
  end
end

And(/^I should see (.+) rank and name for section 8$/) do |_rank|
  BrowserActions.scroll_down
  sleep 1
  is_equal(on(Section8Page).rank_name_and_date_elements.first.text, "Rank/Name\n#{_rank}")
end

And(/^I should see signed date and time for section 8$/) do
  is_equal(on(Section8Page).rank_name_and_date_elements[1].text,
           "Date & Time\n#{on(Section8Page).get_signed_date_time}")
end

Then(/^I should see default section 8 questions$/) do
  to_exists(on(Section8Page).default_section8_question1_element)
  to_exists(on(Section8Page).default_section8_question2_element)
  to_exists(on(Section8Page).default_section8_question3_element)
  to_exists(on(Section8Page).default_section8_question4_element)
end

Then(/^I (should|should not) see EIC normalize extra questions$/) do |_condition|
  BrowserActions.scroll_down
  sleep 1
  if _condition === 'should'
    step 'I should see first 28 input fields else 26 input fields'
    # is_equal($browser.find_elements(:xpath, '//input').size, '28')
    to_exists(on(Section8Page).normalization_question1_element)
    to_exists(on(Section8Page).normalization_question2_element)
    to_exists(on(Section8Page).normalization_question3_element)
    to_exists(on(Section8Page).normalization_question4_element)
    to_exists(on(Section8Page).normalization_question5_element)
    step 'I should see default section 8 questions'
  end
  if _condition === 'should not'
    step 'I should see first 18 input fields else 16 input fields'
    # is_equal($browser.find_elements(:xpath, '//input').size, '18')
    not_to_exists(on(Section8Page).normalization_question1_element)
    not_to_exists(on(Section8Page).normalization_question2_element)
    not_to_exists(on(Section8Page).normalization_question3_element)
    not_to_exists(on(Section8Page).normalization_question4_element)
    not_to_exists(on(Section8Page).normalization_question5_element)
  end
end

Then(/^I should see EIC extra questions for work on pressure pipe permit$/) do
  to_exists(on(Section8Page).normalization_pipe_question1_element)
  to_exists(on(Section8Page).normalization_pipe_question2_element)
  # is_equal($browser.find_elements(:xpath, '//input').size, '22')
  step 'I should see first 22 input fields else 20 input fields'
  step 'I should see default section 8 questions'
end

And(/^I sign EIC section 8 with RA (.+) rank$/) do |_rank|
  on(Section3APage).scroll_multiple_times(4)
  on(Section8Page).submit_termination_btn_elements.first.click
  step "I sign on canvas with valid #{_rank} rank"
  sleep 2
  step 'I click on back to home'
end

And(/^I manually put the permit to pending termination state$/) do
  sleep 1
  step 'I click on Submit for Termination'
  on(PinPadPage).enter_pin('9015')
  sleep 1
  on(Section8Page).task_status_completed_element.click
  step 'I sign EIC section 8 with RA A/M rank'
end

Then(/^I should see task commenced data and time populated with permit activated date and timestamp$/) do
  does_include(@@issued_date_and_time, on(Section8Page).task_commerce_at_elements.first.text)
  does_include(@@issued_date_and_time, on(Section8Page).task_commerce_at_elements.last.text)
end
