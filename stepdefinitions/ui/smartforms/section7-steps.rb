# frozen_string_literal: true

And (/^I click on permit for master (.+)$/) do |_approve_or_review|
  match_element = on(CreatedPermitToWorkPage).select_created_permit_with_param(on(BypassPage).get_permit_id)
  match_element.click
  step 'I enter pin 1111'
  sleep 1
  on(Section1Page).next_btn_elements.first.click
end

Then (/^I should see approve and request update buttons$/) do
  is_equal(on(Section7Page).non_oa_buttons_elements.size, 4)
  is_equal(on(Section7Page).non_oa_buttons_elements.first.text, 'Activate Permit To Work')
  is_equal(on(Section7Page).non_oa_buttons_elements[1].text, 'Request Updates')
end

Then (/^I should see submit for office approval and request update buttons$/) do
  is_equal(on(Section7Page).non_oa_buttons_elements.size, 7)
  is_equal(on(Section7Page).non_oa_buttons_elements[3].text, 'Submit for Office Approval')
  is_equal(on(Section7Page).non_oa_buttons_elements[4].text, 'Updates Needed')
end

And (/^I open a permit pending Master (.+) with (.+) rank and (.+) pin$/) do |_approve_or_review, _rank, _pin|
  on(SmartFormsPermissionPage).master_approval_elements[0].click
  step "I enter pin #{_pin}"
end
