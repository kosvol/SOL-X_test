# frozen_string_literal: true

And (/^I navigate to section (.+)$/) do |_which_section|
  on(Section6Page).toggle_to_section(_which_section)
end

Then (/^I should see master review button only$/) do
  is_equal(on(Section6Page).submit_btn_elements.size, '1')
  BrowserActions.scroll_down
  sleep 1
  BrowserActions.scroll_down
  is_equal(on(Section6Page).submit_btn_elements.first.text, "Submit for Master's Review")
end

Then (/^I should see master approval button only$/) do
  BrowserActions.scroll_down
  sleep 1
  BrowserActions.scroll_down
  BrowserActions.scroll_down
  is_equal(on(Section6Page).submit_btn_elements.size, '1')
  is_equal(on(Section6Page).submit_btn_elements.first.text, "Submit for Master's Approval")
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
  on(Section0Page).set_current_time
  on(Section6Page).submit_btn_elements[0].click
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
