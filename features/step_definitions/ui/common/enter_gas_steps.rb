# frozen_string_literal: true

And(/^I add all gas readings and back from signing screen$/) do
  step 'I trigger gas readings input with C/O rank'
  on(Section6Page).add_all_gas_readings
  on(Section6Page).review_sign_btn
  sleep 1
  on(Section6Page).back_btn
  on(Section6Page).back_btn
end

And(/^I add all gas readings and cancel from pin screen$/) do
  step 'I trigger gas readings input with C/O rank'
  on(Section6Page).add_all_gas_readings
  on(Section6Page).review_sign_btn
  on(SignaturePage).sign_and_select_location
  sleep 1
  on(Section6Page).cancel_btn
end

And(/^I trigger gas readings input with (.*) rank$/) do |rank|
  BrowserActions.wait_until_is_visible(on(Section6Page).add_gas_btn_button)
  on(Section6Page).add_gas_btn_button
  step "I enter pin via service for rank #{rank}"
end

Then('I should see correct placeholder text for gas input') do
  is_equal(on(Section6Page).o2_input_element.attribute('placeholder'), 'Required (Limit 20.9 %)')
  is_equal(on(Section6Page).hc_input_element.attribute('placeholder'), 'Required (Limit 1 % LEL)')
  is_equal(on(Section6Page).h2s_input_element.attribute('placeholder'), 'Required (TLV-TWA 5 PPM)')
  is_equal(on(Section6Page).co_input_element.attribute('placeholder'), 'Required (TLV-TWA 25 PPM)')
end

Then('I should see submit button disabled before signing and location filled') do
  on(Section6Page).normal_gas_readings('1', '2', '3', '4')
  on(Section6Page).review_sign_btn
  on(SignaturePage).sign_on_canvas
  is_disabled(on(Section6Page).enter_pin_and_submit_btn_element)
end

And(/^I add (all|only normal) gas readings with (.*) rank$/) do |condition, rank|
  on(Section6Page).gas_equipment_input = 'Test Automation'
  on(Section6Page).gas_sr_number_input = 'Test Automation'
  on(Section6Page).gas_last_calibration_button
  on(Section6Page).select_todays
  step "I trigger gas readings input with #{rank} rank"
  on(Section6Page).add_all_gas_readings if condition == 'all'
  on(Section6Page).normal_gas_readings('1', '2', '3', '4') if condition == 'only normal'
  sleep 1
  step 'I sign for gas'
end

And(/^I sign for gas$/) do
  on(Section6Page).review_sign_btn
  on(SignaturePage).sign_and_select_location
  sleep 1
  on(Section6Page).enter_pin_and_submit_btn
end

And(/^I am able to delete toxic gas inputs$/) do
  step 'I trigger gas readings input with C/O rank'
  on(Section6Page).add_all_gas_readings
  sleep 1
  is_equal(on(Section6Page).toxic_gas_reading_elements.size, 4)
  on(Section6Page).toxic_gas_reading_elements.last.click
  on(Section6Page).remove_toxic_btn
  sleep 1
  is_equal(on(Section6Page).toxic_gas_reading_elements.size, 0)
end

Then(/^I should see gas reading still exists$/) do
  sleep 1
  is_equal(on(Section6Page).o2_input, '1')
  is_equal(on(Section6Page).hc_input, '2')
  is_equal(on(Section6Page).h2s_input, '3')
  is_equal(on(Section6Page).co_input, '4')
end

Then(/^I should be able to continue to next page$/) do
  sleep 1
  on(Section6Page).o2_input = '123'
  on(Section6Page).hc_input = '123'
  on(Section6Page).h2s_input = '123'
  on(Section6Page).co_input = '123'
  is_enabled(on(Section6Page).continue_btn_element)
end
