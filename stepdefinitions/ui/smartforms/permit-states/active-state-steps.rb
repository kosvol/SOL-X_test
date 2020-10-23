# frozen_string_literal: true

Then (/^I (should|should not) see competent person sign button exists$/) do |_condition|
  sleep 1
  if _condition === 'should not'
    not_to_exists(on(Section8Page).competent_person_btn_element)
  end
  if _condition === 'should'
    to_exists(on(Section8Page).competent_person_btn_element)
  end
end

Then (/^I should see issue date display$/) do
  does_include(on(CreatedPermitToWorkPage).issued_date_time_elements.first.text, 'LT (GMT+')
  does_include(on(CreatedPermitToWorkPage).issued_date_time_elements.first.text, on(Section4APage).get_current_date_mm_yyyy_format)
  # is_equal(@@created_permit_data[1], on(CreatedPermitToWorkPage).issued_date_time_elements.first.text)
end

Then (/^I should see (.+) as button text$/) do |update_or_view|
  update_reading_or_view_btn = on(CreatedPermitToWorkPage).select_created_permit_with_param(CommonPage.get_permit_id)
  if update_or_view === 'Update Readings'
    is_equal(update_reading_or_view_btn.text, 'Update Readings')
  elsif update_or_view === 'View'
    is_equal(update_reading_or_view_btn.text, 'View')
  end
end

And (/^I (.+) permit with (.+) rank and (.+) pin$/) do |_update_or_terminate, _rank, _pin|
  sleep 1
  if _update_or_terminate === 'update'
    on(CreatedPermitToWorkPage).select_created_permit_with_param(CommonPage.get_permit_id).click
  elsif _update_or_terminate === 'terminate'
    on(ActiveStatePage).get_termination_btn(CommonPage.get_permit_id).click
  end
  sleep 1
  step "I enter pin #{_pin}"
end

And (/^I should see Add Gas Reading button (.+)$/) do |_enable_or_disable|
  sleep 1
  step 'I navigate to section 6'
  _enable_or_disable === 'enabled' ? is_enabled(on(Section6Page).add_gas_btn_element) : is_disabled(on(Section6Page).add_gas_btn_element)
end

Then (/^I should see permit valid for (.+) hours$/) do |_duration|
  permit_validity_timer = on(ActiveStatePage).get_permit_validity_period(on(ActiveStatePage).get_permit_index(CommonPage.get_permit_id))
  is_true(on(ROLPage).is_duration?(permit_validity_timer, _duration))
end

And (/^I set rol permit to active state with (.+) duration$/) do |_duration|
  sleep 2
  step 'I open a permit pending Master Approval with Master rank and 1111 pin'
  step 'I press next for 1 times'
  on(ROLPage).submit_rol_permit_w_duration(_duration)
  step 'I enter pin 1111'
  step 'I sign on canvas'
end

And (/^I approve permit$/) do
  step 'I open a permit pending Master Approval with Master rank and 1111 pin'
  step 'I press next for 11 times'
  sleep 1
  step 'I sign the permit for submission to pending state'
end

And (/^I sign the permit for submission to pending state$/) do
  on(Section7Page).activate_permit_btn
  step 'I enter pin 1111'
  on(Section7Page).activate_permit
end
