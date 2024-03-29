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
  # is_equal(@browser.find_elements(:xpath, '//input').size, '28')
end

Then(/^I should see extra section8 questions for pipe permit$/) do
  to_exists(on(Section8Page).normalization_pipe_question1_element)
  to_exists(on(Section8Page).normalization_pipe_question2_element)
  step 'I should see default section 8 questions'
  tmp = on(Section8Page).ret_all_page_span
  section8_questions = YAML.load_file('data/section8-questions.yml')
  tmp.each do |elem|
    does_include(section8_questions['pipe'], elem.text)
  end
  step 'I should see first 32 input fields else 30 input fields'
end

Then(/^I should see extra section8 questions for critical maintenance permit$/) do
  to_exists(on(Section8Page).normalization_crit_question1_element)
  to_exists(on(Section8Page).normalization_crit_question2_element)
  to_exists(on(Section8Page).normalization_crit_question3_element)
  step 'I should see default section 8 questions'
  tmp = on(Section8Page).ret_all_page_span
  section8_questions = YAML.load_file('data/section8-questions.yml')
  tmp.each do |elem|
    does_include(section8_questions['critical'], elem.text)
  end
  step 'I should see first 37 input fields else 35 input fields'
end

Then(/^I should see extra section8 questions for electrical permit$/) do
  to_exists(on(Section8Page).normalization_elec_question1_element)
  to_exists(on(Section8Page).normalization_elec_question2_element)
  step 'I should see default section 8 questions'
  tmp = on(Section8Page).ret_all_page_span
  section8_questions = YAML.load_file('data/section8-questions.yml')
  tmp.each do |elem|
    does_include(section8_questions['electrical'], elem.text)
  end
  step 'I should see first 34 input fields else 32 input fields'
end

And('I should see first {int} input fields else {int} input fields') do |first_input_fields_length, second_input_fields_length|
  input_fields = on(Section4APage).tool_box_elements.size
  case input_fields
  when first_input_fields_length
    is_equal(input_fields, first_input_fields_length)
  when second_input_fields_length
    is_equal(input_fields, second_input_fields_length)
  else
    raise "Wrong type of input fields >>> #{input_fields}"
  end
end

And(/^I should see (.+) rank and name for section 8$/) do |rank|
  BrowserActions.scroll_down
  sleep 1
  is_equal(on(Section8Page).rank_name_and_date_elements.first.text, rank)
end

And(/^I should see signed date and time for section 8$/) do
  is_equal(on(Section8Page).rank_name_and_date_elements[1].text,
           on(Section8Page).get_signed_date_time.to_s)
end

Then(/^I should see default section 8 questions$/) do
  to_exists(on(Section8Page).default_section8_question1_element)
  to_exists(on(Section8Page).default_section8_question2_element)
  to_exists(on(Section8Page).default_section8_question3_element)
  to_exists(on(Section8Page).default_section8_question4_element)
end

Then(/^I (should|should not) see EIC normalize extra questions$/) do |condition|
  BrowserActions.scroll_down
  sleep 1
  if condition == 'should'
    step 'I should see first 28 input fields else 26 input fields'
    # is_equal(@browser.find_elements(:xpath, '//input').size, '28')
    to_exists(on(Section8Page).normalization_question1_element)
    to_exists(on(Section8Page).normalization_question2_element)
    to_exists(on(Section8Page).normalization_question3_element)
    to_exists(on(Section8Page).normalization_question4_element)
    to_exists(on(Section8Page).normalization_question5_element)
    step 'I should see default section 8 questions'
  else
    step 'I should see first 18 input fields else 16 input fields'
    # is_equal(@browser.find_elements(:xpath, '//input').size, '18')
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
  step 'I should see first 22 input fields else 20 input fields'
  step 'I should see default section 8 questions'
end

And(/^I sign EIC section 8 with RA (.+) rank$/) do |rank|
  on(Section3APage).scroll_times_direction(4, 'down')
  step 'I submit permit for termination'
  step "I sign with valid #{rank} rank"
  sleep 2
  step 'I click on back to home'
end

And(/^I submit permit for termination$/) do
  on(Section8Page).submit_termination_btn_elements.first.click
end

And(/^I manually put the permit to pending termination state$/) do
  sleep 1
  step 'I review and withdraw permit with C/O rank'
  sleep 1
  on(Section8Page).task_status_completed_element.click
  step 'I sign EIC section 8 with RA C/O rank'
end

Then(/^I should see task commenced data and time populated with permit activated date and timestamp$/) do
  does_include(@@issued_date_and_time, on(Section8Page).task_commerce_at_elements.first.text)
  does_include(@@issued_date_and_time, on(Section8Page).task_commerce_at_elements.last.text)
end
