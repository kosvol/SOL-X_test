# frozen_string_literal: true

Then(/^I (should|should not) see terminate permit to work and request update buttons$/) do |condition|
  if condition == 'should'
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 6)
    is_equal(on(Section7Page).non_oa_buttons_elements[2].text, 'Withdraw Permit To Work')
    is_equal(on(Section7Page).non_oa_buttons_elements[3].text, 'Request Updates')
  else
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 2)
    is_equal(on(Section7Page).close_btn_elements.first.text, 'Close')
    is_equal(on(Section7Page).previous_btn_elements.first.text, 'Previous')
  end
end

Then(/^I (should|should not) see terminate permit to work and request update buttons for FSU$/) do |condition|
  if condition == 'should'
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 5)
    is_equal(on(Section7Page).non_oa_buttons_elements[1].text, 'Withdraw Permit To Work')
    is_equal(on(Section7Page).non_oa_buttons_elements[2].text, 'Request Updates')
  else
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 2)
    is_equal(on(Section7Page).close_btn_elements.first.text, 'Close')
    is_equal(on(Section7Page).previous_btn_elements.first.text, 'Previous')
  end
end

Then(/^I should see date and time pre-fill on section 9$/) do
  step 'I set time'
  is_true(on(Section9Page).termntd_date_time_filled?)
end