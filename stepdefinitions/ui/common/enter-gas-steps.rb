And (/^I add all gas readings and back from signing screen$/) do
    on(Section6Page).add_all_gas_readings
    on(Section6Page).review_sign_btn
    sleep 1
    on(Section6Page).back_btn
    on(Section6Page).back_btn
  end
  
  And (/^I add all gas readings and cancel from pin screen$/) do
    on(Section6Page).add_all_gas_readings
    step "I sign for gas"
    on(Section6Page).cancel_btn
  end
  
  And (/^I add (all|only normal) gas readings$/) do |_condition|
    on(Section6Page).gas_equipment_input="Test Automation"
    on(Section6Page).gas_sr_number_input="Test Automation"
    on(Section6Page).gas_last_calibration_button
    sleep 1
    on(Section6Page).select_todays_date_from_calendar
    on(Section6Page).add_all_gas_readings if _condition === 'all'
    on(Section6Page).add_normal_gas_readings if _condition === 'only normal'
    sleep 1
    step "I sign for gas"
  end
  
  And (/^I sign for gas$/) do
    on(Section6Page).review_sign_btn
    on(SignaturePage).sign_and_select_location
    on(Section6Page).enter_pin_and_submit_btn
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