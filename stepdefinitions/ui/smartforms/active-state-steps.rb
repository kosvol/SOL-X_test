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
    termination_btn = on(ActiveStatePage).get_on_termination_btn(on(BypassPage).get_selected_permit)
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

Then (/^I (should|should not) see EIC normalize extra questions$/) do |_condition|
  sleep 1
  if _condition === 'should'
    is_equal($browser.find_elements(:xpath, '//input').size, '25')
  end
  if _condition === 'should not'
    is_equal($browser.find_elements(:xpath, '//input').size, '15')
  end
end
