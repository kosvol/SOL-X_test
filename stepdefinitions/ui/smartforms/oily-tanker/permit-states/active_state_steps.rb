# frozen_string_literal: true

Then(/^I should not see competent and issuing person sign button exists$/) do
  on(Section3APage).scroll_times_direction(8, 'down')
  not_to_exists(on(Section8Page).competent_person_btn_element)
  not_to_exists(on(Section8Page).issuing_authority_btn_element)
  is_equal(on(Section5Page).sign_btn_role_elements.size, 0)
end

Then(/^I should see issue date display$/) do
  does_include(on(CreatedPermitToWorkPage).issued_date_time_elements.first.text, on(CommonFormsPage).get_timezone)
  does_include(on(CreatedPermitToWorkPage).issued_date_time_elements.first.text,
               on(CommonFormsPage).ret_current_date_format_with_offset)
  does_include(on(CreatedPermitToWorkPage).issued_date_time_elements.first.text, on(CommonFormsPage).return_current_hour)
end

Then(/^I should see (.+) as button text$/) do |update_or_view|
  update_reading_or_view_btn = on(ActiveStatePage)
                               .add_gas_btn_elements[on(CreatedPermitToWorkPage)
                               .get_permit_index(CommonPage.return_permit_id)].click
  case update_or_view
  when 'Update Readings'
    is_equal(update_reading_or_view_btn.text, 'Update Readings')
  when 'View'
    is_equal(update_reading_or_view_btn.text, 'View')
  else
    raise "Wrong condition >>> #{update_or_view}"
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

Then(/^I should see permit valid for (.+) hours$/) do |duration|
  sleep 1
  permit_validity_timer = on(ActiveStatePage)
                          .get_permit_validity_period(on(ActiveStatePage)
                                                        .get_permit_index(CommonPage.return_permit_id))
  p ">> timer: #{permit_validity_timer}"
  is_true(on(ROLPage).is_duration?(permit_validity_timer, duration))
end

And(/^I set rol permit to active state with (.+) duration$/) do |duration|
  sleep 1
  step 'I open a permit pending Master Approval with MAS rank'
  step 'I press next for 1 times'
  on(ROLPage).submit_rol_permit_w_duration(duration)
  step 'I sign with valid MAS rank'
  step 'I click on back to home'
end

And(/^I set rol permit to active state with (.+) duration with CE$/) do |duration|
  sleep 1
  step 'I open a permit pending Master Approval with C/E rank'
  step 'I press next for 1 times'
  on(ROLPage).submit_rol_permit_w_duration(duration)
  step 'I sign with valid C/E rank'
end

And(/^I select rol permit active duration (.*) hour$/) do |duration|
  on(ROLPage).select_rol_duration(duration)
end

Then(/^I should see data persisted on page (.*)$/) do |page_number|
  rol_data = YAML.load_file('data/filled-forms-base-data/rol.yml')
  case page_number
  when '1'
    step 'I press previous for 2 times'
    tmp = on(Section3DPage).filled_section
    does_include(tmp[1], "AUTO/DRA/#{BrowserActions.get_year}/")
    does_include(tmp[2], on(Section0Page).ret_current_date_format_with_offset)
    # data cleanse after first assertion
    tmp.delete_at(1)
    tmp.delete_at(1)
    tmp.delete_at(9)
    tmp.delete_at(9)
    p ">> #{tmp}"
    is_equal(tmp, rol_data['page1'])
  when '2'
    sleep 1
    tmp = on(Section3DPage).filled_section
    p ">> #{tmp}"
    does_include(tmp[1], 'COTAUTO')
    does_include(tmp[2], on(CommonFormsPage).get_timezone)
    does_include(tmp[2], on(Section0Page).ret_current_date_format_with_offset)
    tmp.delete_at(2)
    does_include(tmp[19], on(CommonFormsPage).get_timezone)
    does_include(tmp[21], on(CommonFormsPage).get_timezone)
    does_include(tmp[19], on(Section0Page).ret_current_date_format_with_offset)
    does_include(tmp[21], on(Section0Page).ret_current_date_format_with_offset)
    tmp.delete_at(19)
    tmp.delete_at(20)
    p "<< #{tmp}"
    is_equal(tmp, rol_data['page2'])
  else
    raise "Wrong page number >> #{page_number}"
  end
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
