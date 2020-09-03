# frozen_string_literal: true

Then (/^I (should|should not) see terminate permit to work and request update buttons$/) do |_condition|
  if _condition === 'should'
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 6)
    is_equal(on(Section7Page).non_oa_buttons_elements[2].text, 'Terminate Permit To Work')
    is_equal(on(Section7Page).non_oa_buttons_elements[3].text, 'Request Updates')
  elsif _condition === 'should not'
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 2)
    is_equal(on(Section7Page).close_btn_element.text, 'Close')
    is_equal(on(Section7Page).previous_btn_element.text, 'Previous')
  end
end
