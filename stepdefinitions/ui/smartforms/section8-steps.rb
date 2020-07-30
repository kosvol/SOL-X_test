# frozen_string_literal: true

And (/^I should see (.+) rank and name for section 8$/) do |_rank|
  BrowserActions.scroll_down
  sleep 3
  is_equal(on(Section8Page).rank_name_and_date_elements.last.text,on(Section8Page).get_signed_date_time)
  is_equal(on(Section8Page).rank_name_and_date_elements.first.text, _rank)
end

And (/^I should see signed date and time for section 8$/) do
  on(SmartFormsPermissionPage).set_current_time
  is_equal(on(Section8Page).rank_name_and_date_elements.last.text, on(Section8Page).get_signed_date_time)
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

Then (/^I should see EIC extra questions for work on pressure pipe permit$/) do
  is_equal($browser.find_elements(:xpath, '//input').size, '19')
  rescue
  is_equal($browser.find_elements(:xpath, '//input').size, '29')
end

And (/^I sign EIC section 8 with RA (.+)$/) do |_pin|
  BrowserActions.scroll_down
  BrowserActions.scroll_down
  BrowserActions.scroll_down
  BrowserActions.scroll_down
  on(Section4BPage).subform_btn_elements[2].click
  @@entered_pin = _pin.to_i
  on(PinPadPage).enter_pin(@@entered_pin)
  step 'I sign on canvas'
end
