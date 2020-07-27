# frozen_string_literal: true

Then (/^I should see (.+) as button text$/) do |update_or_view|
  update_reading_or_view_btn = on(ActiveStatePage).select_created_permit_with_param(on(BypassPage).get_selected_permit)
  if update_or_view === 'Update Readings'
    is_equal(update_reading_or_view_btn.text, 'Update Readings')
  elsif update_or_view === 'View'
    is_equal(update_reading_or_view_btn.text, 'View')
  end
end

And (/^I (.+) permit with (.+) rank and (.+) pin$/) do |_update_or_terminate, _rank, _pin|
  sleep 1
  if _update_or_terminate === 'update active'
    update_reading_or_view_btn = on(ActiveStatePage).select_created_permit_with_param(on(BypassPage).get_selected_permit)
    update_reading_or_view_btn.click
  elsif _update_or_terminate === 'terminate'
    termination_btn = on(ActiveStatePage).get_termination_btn(on(BypassPage).get_selected_permit)
    termination_btn.click
  end
  step "I enter pin #{_pin}"
end

And (/^I should see Add Gas Reading button (.+)$/) do |_enable_or_disable|
  sleep 1
  on(Section1Page).next_btn_elements.first.click
  sleep 1
  step 'I press next for 9 times'
  _enable_or_disable === 'enabled' ? is_enabled(on(Section6Page).add_gas_reading_btn_element) : is_disabled(on(Section6Page).add_gas_reading_btn_element)
end

Then (/^I should see permit valid for (.+) hours$/) do |_duration|
  permit_validity_timer = on(ActiveStatePage).get_permit_validity_period(on(ActiveStatePage).get_permit_index(on(BypassPage).get_permit_id))
  does_include(permit_validity_timer, '00:59:') if _duration === '1'
  does_include(permit_validity_timer, '01:59:') if _duration === '2'
  does_include(permit_validity_timer, '02:59:') if _duration === '3'
  does_include(permit_validity_timer, '03:59:') if _duration === '4'
  does_include(permit_validity_timer, '04:59:') if _duration === '5'
  does_include(permit_validity_timer, '05:59:') if _duration === '6'
  does_include(permit_validity_timer, '06:59:') if _duration === '7'
  does_include(permit_validity_timer, '07:59:') if _duration === '8'
end

When (/^I press next from section 1$/) do
  on(Section1Page).next_btn_elements.first.click
end

And (/^I set rol permit to active state with (.+) duration$/) do |_duration|
  on(BypassPage).set_rol_to_active(_duration)
end
