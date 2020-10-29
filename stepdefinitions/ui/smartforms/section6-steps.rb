# frozen_string_literal: true

Then (/^I should see master (approval|review) button only$/) do |_condition|
  on(Section3APage).scroll_multiple_times(2)
  is_equal(on(Section6Page).submit_btn_elements.size, '1')
  if _condition === 'approval'
    is_equal(on(Section6Page).submit_btn_elements.first.text, "Submit for Master's Approval")
  end
  if _condition === 'review'
    is_equal(on(Section6Page).submit_btn_elements.first.text, "Submit for Master's Review")
  end
end

Then (/^I (should|should not) see gas reader sections$/) do |_condition|
  sleep 1
  is_true(on(Section6Page).is_gas_reader_section?) if _condition === 'should'
  if _condition === 'should not'
    is_true(!on(Section6Page).is_gas_reader_section?)
  end
end

Then (/^I (should|should not) see gas reader sections on active permit$/) do |_condition|
  sleep 1
  step 'I navigate to section 6'
  step "I #{_condition} see gas reader sections"
end

Then (/^I submit permit for Master (.+)$/) do |_approval_or_review|
  sleep 1
  step 'I set time'
  if _approval_or_review === 'Approval'
    BrowserActions.scroll_click(on(PendingStatePage).submit_for_master_approval_btn_elements.first)
  end
  if _approval_or_review === 'Review'
    BrowserActions.scroll_click(on(PendingStatePage).submit_master_review_btn_elements.first)
  end
  step 'I enter pin 9015'
  step 'I sign on canvas'
  # data collector; will evolve
  # on(Section0Page).reset_data_collector
  # @@created_permit_data = on(Section1Page).set_section1_filled_data
end

And(/^I press the (.+) button to (disable|enable) gas testing$/) do |key, _type|
  on(Section6Page).gas_testing_switcher(key)
end

Then(/^I (should|should not) see warning label$/) do |_condition|
  info_text = 'You have selected to disable gas testing for this permit.'
  if _condition === 'should'
    is_equal(on(Section6Page).info_box_disable_gas, info_text)
  end
  if _condition === 'should not'
    is_equal(on(Section6Page).is_info_box_disable_gas_exist?, false)
  end
end

And(/^I (should|should not) see gas_equipment_input$/) do |_condition|
  if _condition === 'should'
    to_exists(on(Section6Page).gas_equipment_input_element)
  elsif _condition === 'should not'
    not_to_exists(on(Section6Page).gas_equipment_input_element)
  end
end

And(/^I (should|should not) see gas_sr_number_input$/) do |_condition|
  if _condition === 'should'
    to_exists(on(Section6Page).gas_sr_number_input_element)
  elsif _condition === 'should not'
    not_to_exists(on(Section6Page).gas_sr_number_input_element)
  end
end

And(/^I (should|should not) see gas_last_calibration_button$/) do |_condition|
  if _condition === 'should'
    to_exists(on(Section6Page).gas_last_calibration_button_element)
  elsif _condition === 'should not'
    not_to_exists(on(Section6Page).gas_last_calibration_button_element)
  end
end

Then (/^I should see gas reading still exists$/) do
  sleep 1
  is_equal(on(Section6Page).o2_input, '1')
  is_equal(on(Section6Page).hc_input, '2')
  is_equal(on(Section6Page).h2s_input, '3')
  is_equal(on(Section6Page).co_input, '4')
end

Then (/^I should be able to continue to next page$/) do
  sleep 1
  on(Section6Page).o2_input = '123'
  on(Section6Page).hc_input = '123'
  on(Section6Page).h2s_input = '123'
  on(Section6Page).co_input = '123'
  is_enabled(on(Section6Page).continue_btn_element)
end

And (/^I add all gas readings and back from signing screen$/) do
  on(Section6Page).add_all_gas_readings
  on(Section6Page).review_sign_btn
  sleep 1
  on(Section6Page).back_btn
  on(Section6Page).back_btn
end

And (/^I add all gas readings and cancel from pin screen$/) do
  on(Section6Page).add_all_gas_readings
  on(Section6Page).review_sign_btn
  on(Section3DPage).sign_for_gas
  on(Section6Page).enter_pin_and_submit_btn
  on(Section6Page).cancel_btn
end

And (/^I add (all|only normal) gas readings$/) do |_condition|
  on(Section6Page).add_all_gas_readings if _condition === 'all'
  on(Section6Page).add_normal_gas_readings if _condition === 'only normal'
  on(Section6Page).review_sign_btn
  on(Section3DPage).sign_for_gas
  on(Section6Page).enter_pin_and_submit_btn
end

And (/^I will see popup dialog with (.+) crew rank and name$/) do |_rank_name|
  is_equal(on(Section6Page).get_gas_added_by(_rank_name).text, _rank_name)
  # is_equal(on(Section6Page).gas_reader_by,_rank_name)
  on(Section6Page).done_btn_elements.last.click
end

Then (/^I should see gas reading display (with|without) toxic gas$/) do |_condition|
  on(Section3APage).scroll_multiple_times(2)
  if _condition === 'with'
    is_equal(on(Section6Page).gas_reading_table_elements[1].text, 'Initial')
  end
  if _condition === 'without'
    is_equal(on(Section6Page).gas_reading_table_elements[1].text, '2nd Reading')
  end
  is_equal(on(Section6Page).gas_reading_table_elements[2].text, "#{on(Section6Page).get_current_date_format_with_offset} #{on(Section6Page).get_current_time_format}")
  is_equal(on(Section6Page).gas_reading_table_elements[3].text, '1 %')
  is_equal(on(Section6Page).gas_reading_table_elements[4].text, '2 % LEL')
  is_equal(on(Section6Page).gas_reading_table_elements[5].text, '3 PPM')
  is_equal(on(Section6Page).gas_reading_table_elements[6].text, '4 PPM')
  if _condition === 'with'
    is_equal(on(Section6Page).gas_reading_table_elements[7].text, '1.5 CC')
  end
  if _condition === 'without'
    is_equal(on(Section6Page).gas_reading_table_elements[7].text, '- ')
  end
  is_equal(on(Section6Page).gas_reading_table_elements[8].text, 'A/M Atif Hayat')
end

And (/^I am able to delete toxic gas inputs$/) do
  on(Section6Page).add_all_gas_readings
  sleep 1
  is_equal(on(Section6Page).toxic_gas_reading_elements.size, 4)
  on(Section6Page).toxic_gas_reading_elements.last.click
  on(Section6Page).remove_toxic_btn
  sleep 1
  is_equal(on(Section6Page).toxic_gas_reading_elements.size, 0)
end

And (/^I should see submit button enabled$/) do
  on(CommonFormsPage).done_btn_elements.first.click
  is_enabled(on(CommonFormsPage).submit_for_master_approval_btn_elements.first)
end
