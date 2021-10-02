# frozen_string_literal: true

Then(/^I should see gas reading copy text$/) do
  p ">> #{on(Section6Page).gas_notes_element.text}"
end

Then(/^I should see incomplete fields warning message display$/) do
  is_equal(on(Section6Page).info_warning_boxes_elements.first.text, 'Please Complete The Following Sections')
  is_equal(on(Section6Page).info_warning_boxes_elements[1].text,
           "Section 1: Task Description\nSection 3C: DRA - Team Members\nHelicopter Operation\nSection 5: Responsibility Acceptance")
end

And(/^I should see incomplete signature field warning message display$/) do
  on(Section3APage).scroll_multiple_times_with_direction(5, 'down')
  is_equal(on(Section6Page).info_warning_boxes_elements[2].text,
           'This permit has required fields missing. To submit it for approval, please sign at the following sections')
  does_include(on(Section6Page).info_warning_boxes_elements[3].text, 'Helicopter Operation')
end

Then(/^I should see master (approval|review) button only$/) do |condition|
  sleep 1
  BrowserActions.wait_until_is_visible(on(Section6Page).submit_btn_elements.first)
  on(Section3APage).scroll_multiple_times_with_direction(4, 'down')
  is_equal(on(Section6Page).submit_btn_elements.size, 1)
  is_equal(on(Section6Page).submit_btn_elements.first.text, "Submit for Master's Approval") if condition == 'approval'
  is_equal(on(Section6Page).submit_btn_elements.first.text, "Submit for Master's Review") if condition == 'review'
end

Then(/^I (should|should not) see gas reader sections$/) do |condition|
  sleep 1
  is_true(on(Section6Page).is_gas_reader_section?) if condition == 'should'
  is_true(!on(Section6Page).is_gas_reader_section?) if condition == 'should not'
end

Then(/^I (should|should not) see gas reader sections on active permit$/) do |condition|
  sleep 1
  step "I #{condition} see gas reader sections"
end

Then(/^I submit permit for Master (.+)$/) do |approval_or_review|
  sleep 1
  step 'I set time'
  if approval_or_review == 'Approval'
    BrowserActions.scroll_click(on(PendingStatePage).submit_for_master_approval_btn_elements.first)
  end
  if approval_or_review == 'Review'
    BrowserActions.scroll_click(on(PendingStatePage).submit_master_review_btn_elements.first)
  end
  step 'I sign with valid C/O rank' if (EnvironmentSelector
                                          .current_environment
                                          .include? 'sit') || (EnvironmentSelector
                                                                 .current_environment
                                                                 .include? 'auto')
  if EnvironmentSelector.current_environment == 'uat'
    step 'I enter pin via service for rank C/O'
    step 'I sign on canvas'
  end
end

Then(/^I submit smoke test permit$/) do
  sleep 1
  BrowserActions.scroll_click(on(PendingStatePage).submit_for_master_approval_btn_elements.first)
  sleep 1
  step 'I sign with valid C/O rank'
end

And(/^I press the (.+) button to (disable|enable) gas testing$/) do |key, _type|
  sleep 1
  on(Section6Page).gas_testing_switcher(key)
end

Then(/^I (should|should not) see warning label$/) do |condition|
  info_text = "Gas Testing Disabled\nYou have selected to disable gas testing for this permit."
  if condition == 'should'
    is_equal(on(Section6Page).info_box_disable_gas_elements.first.text, info_text)
  else
    is_equal(on(Section6Page).info_box_disable_gas_elements.size, 0)
  end
end

And(/^I (should|should not) see gas_equipment_input$/) do |condition|
  case condition
  when 'should'
    to_exists(on(Section6Page).gas_equipment_input_element)
  else
    not_to_exists(on(Section6Page).gas_equipment_input_element)
  end
end

And(/^I (should|should not) see gas_sr_number_input$/) do |condition|
  case condition
  when 'should'
    to_exists(on(Section6Page).gas_sr_number_input_element)
  else
    not_to_exists(on(Section6Page).gas_sr_number_input_element)
  end
end

And(/^I (should|should not) see gas_last_calibration_button$/) do |condition|
  case condition
  when 'should'
    to_exists(on(Section6Page).gas_last_calibration_button_element)
  else
    not_to_exists(on(Section6Page).gas_last_calibration_button_element)
  end
end

And(/^I will see popup dialog with (.+) crew rank and name$/) do |rank_name|
  is_equal(on(Section6Page).gas_added_by, "By #{rank_name}")
end

Then(/^I should see gas reading display (with|without) toxic gas and (.*) as gas signer$/) do |condition, rank_name|
  on(Section3APage).scroll_multiple_times_with_direction(2, 'down')
  is_equal(on(Section6Page).gas_reading_table_elements[1].text, 'Initial') if condition == 'with'
  is_equal(on(Section6Page).gas_reading_table_elements[1].text, '2nd Reading') if condition == 'without'
  does_include(on(Section6Page).gas_reading_table_elements[2].text, on(CommonFormsPage).get_timezone.to_s)
  is_equal(on(Section6Page).gas_reading_table_elements[3].text, '1 %')
  is_equal(on(Section6Page).gas_reading_table_elements[4].text, '2 % LEL')
  is_equal(on(Section6Page).gas_reading_table_elements[5].text, '3 PPM')
  is_equal(on(Section6Page).gas_reading_table_elements[6].text, '4 PPM')
  is_equal(on(Section6Page).gas_reading_table_elements[7].text, '1.5 CC') if condition == 'with'
  is_equal(on(Section6Page).gas_reading_table_elements[7].text, '- ') if condition == 'without'
  is_equal(on(Section6Page).gas_reading_table_elements[8].text, rank_name.to_s)
end

And(/^I dismiss gas reader dialog box$/) do
  sleep 1
  BrowserActions.poll_exists_and_click(on(CommonFormsPage).done_btn_elements.first)
end

And(/^I should not see gas reader dialog box$/) do
  if on(CommonFormsPage).done_btn_elements.any?
    raise 'Gas reader dialog box enabled'
  else
    puts 'Expected behavior'
  end
end
