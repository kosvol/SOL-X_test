# frozen_string_literal: true

Then(/^I should not see competent and issuing person sign button exists$/) do
  on(Section3APage).scroll_multiple_times_with_direction(8,'down')
  not_to_exists(on(Section8Page).competent_person_btn_element)
  not_to_exists(on(Section8Page).issuing_authority_btn_element)
  is_equal(on(Section5Page).sign_btn_role_elements.size, 0)
end

Then(/^I should see issue date display$/) do
  does_include(on(CreatedPermitToWorkPage).issued_date_time_elements.first.text, on(CommonFormsPage).get_timezone)
  does_include(on(CreatedPermitToWorkPage).issued_date_time_elements.first.text,
               on(CommonFormsPage).get_current_date_format_with_offset)
  does_include(on(CreatedPermitToWorkPage).issued_date_time_elements.first.text, on(CommonFormsPage).get_current_hour)
end

Then(/^I should see (.+) as button text$/) do |update_or_view|
  update_reading_or_view_btn = on(ActiveStatePage).add_gas_btn_elements[on(CreatedPermitToWorkPage).get_permit_index(CommonPage.get_permit_id)].click
  if update_or_view === 'Update Readings'
    is_equal(update_reading_or_view_btn.text, 'Update Readings')
  elsif update_or_view === 'View'
    is_equal(update_reading_or_view_btn.text, 'View')
  end
end

And(/^I should see gas reading section enabled$/) do
  is_equal(on(Section6Page).gas_yes_no_elements.size, 2)
  is_enabled(on(Section6Page).gas_last_calibration_button_element)
  is_enabled(on(Section6Page).gas_equipment_input_element)
  is_enabled(on(Section6Page).gas_sr_number_input_element)
  is_enabled(on(Section6Page).add_gas_btn_element)
end

And(/^I should see gas reading section enabled in active state$/) do
  is_equal(on(Section6Page).gas_yes_no_elements.size, 0)
  is_enabled(on(Section6Page).add_gas_btn_element)
end

# And (/^I should see Add Gas Reading button disabled$/) do
#   sleep 1
#   not_to_exists(on(Section6Page).gas_yes_no_elements.first)
#   not_to_exists(on(Section6Page).gas_last_calibration_button_element)
#   not_to_exists(on(Section6Page).gas_equipment_input_element)
#   not_to_exists(on(Section6Page).gas_sr_number_input_element)
#   # _enable_or_disable === 'enabled' ? is_enabled(on(Section6Page).add_gas_btn_element) : is_disabled(on(Section6Page).add_gas_btn_element)
#   not_to_exists(on(Section6Page).add_gas_btn_element)
# end

Then(/^I should see permit valid for (.+) hours$/) do |_duration|
  sleep 1
  permit_validity_timer = on(ActiveStatePage).get_permit_validity_period(on(ActiveStatePage).get_permit_index(CommonPage.get_permit_id))
  p ">> timer: #{permit_validity_timer}"
  is_true(on(ROLPage).is_duration?(permit_validity_timer, _duration))
end

And(/^I set rol permit to active state with (.+) duration$/) do |_duration|
  sleep 1
  step 'I open a permit pending Master Approval with MAS rank'
  step 'I press next for 1 times'
  on(ROLPage).submit_rol_permit_w_duration(_duration)
  step 'I sign with valid MAS rank'
  step 'I click on back to home'
end

And(/^I set rol permit to active state with (.+) duration with CE$/) do |_duration|
  sleep 1
  step 'I open a permit pending Master Approval with C/E rank'
  step 'I press next for 1 times'
  on(ROLPage).submit_rol_permit_w_duration(_duration)
  step 'I sign with valid C/E rank'
end

And(/^I select rol permit active duration (.*) hour$/) do |_duration|
  on(ROLPage).select_rol_duration(_duration)
end

Then(/^I should see data persisted on page 2$/) do
  sleep 1
  tmp = on(Section3DPage).get_filled_section
  p ">> #{tmp}"
  does_include(tmp[1], 'COTAUTO')
  does_include(tmp[2], on(CommonFormsPage).get_timezone)
  does_include(tmp[2], on(Section0Page).get_current_date_format_with_offset)
  tmp.delete_at(2)
  does_include(tmp[19], on(CommonFormsPage).get_timezone)
  does_include(tmp[21], on(CommonFormsPage).get_timezone)
  does_include(tmp[19], on(Section0Page).get_current_date_format_with_offset)
  does_include(tmp[21], on(Section0Page).get_current_date_format_with_offset)
  tmp.delete_at(19)
  tmp.delete_at(20)
  p "<< #{tmp}"
  is_equal(tmp, @@rol_data['page2'])
end

And(/^I should see data persisted on page 1$/) do
  @@rol_data = YAML.load_file('data/filled-forms-base-data/rol.yml')
  step 'I press previous for 2 times'
  tmp = on(Section3DPage).get_filled_section
  does_include(tmp[1], "AUTO/DRA/#{BrowserActions.get_year}/")
  # does_include(tmp[2],on(CommonFormsPage).get_timezone)
  does_include(tmp[2], on(Section0Page).get_current_date_format_with_offset)
  # data cleanse after first assertion
  tmp.delete_at(1)
  tmp.delete_at(1)
  tmp.delete_at(9)
  tmp.delete_at(9)
  p ">> #{tmp}"
  is_equal(tmp, @@rol_data['page1'])
end

And(/^I approve permit$/) do
  sleep 3
  step 'I open a permit pending Master Approval with MAS rank'
  sleep 1
  step 'I navigate to section 7'
  sleep 1
  step 'I sign the permit for submission to active state'
end

And(/^I sign the permit for submission to active state$/) do
  on(Section7Page).activate_permit_btn
  step 'I sign with valid MAS rank'
  on(Section7Page).activate_permit
end
