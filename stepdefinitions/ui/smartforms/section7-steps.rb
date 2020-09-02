# frozen_string_literal: true

And (/^I click on permit for master (.+)$/) do |_approve_or_review|
  on(CreatedPermitToWorkPage).select_created_permit_with_param(CommonPage.get_permit_id).click
  # match_element.click
  step 'I enter pin 1111'
  sleep 1
end

Then (/^I (should|should not) see approve and request update buttons$/) do |_condition|
  if _condition === 'should'
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 4)
    is_equal(on(Section7Page).non_oa_buttons_elements.first.text, 'Activate Permit To Work')
    is_equal(on(Section7Page).non_oa_buttons_elements[1].text, 'Request Updates')
  elsif _condition === 'should not'
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 3)
    is_equal(on(Section7Page).close_btn_element.text, 'Close')
    is_equal(on(Section7Page).previous_btn_element.text, 'Previous')
  end
end

Then (/^I (should|should not) see submit for office approval and request update buttons$/) do |_condition|
  if _condition === 'should'
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 5)
    is_equal(on(Section7Page).submit_oa_btn_element.text, 'Submit for Office Approval')
    is_equal(on(Section7Page).update_btn_element.text, 'Updates Needed')
  elsif _condition === 'should not'
    is_equal(on(Section7Page).non_oa_buttons_elements.size, 3)
    is_equal(on(Section7Page).close_btn_element.text, 'Close')
    is_equal(on(Section7Page).previous_btn_element.text, 'Previous')
  end
end

And (/^I open a permit pending Master (.+) with (.+) rank and (.+) pin$/) do |_approve_or_review, _rank, _pin|
  on(Section0Page).master_approval_elements[0].click
  step "I enter pin #{_pin}"
end
